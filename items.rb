require 'rack'
require_relative './lib/senro_controller.rb'
require_relative './lib/router'
require_relative './lib/static'

class Item

  attr_reader :name, :amount

  def self.all
    @item ||= []
  end

  def initialize(params = {})
    params ||= {}
    @name = params["name"]
    @amount = params["amount"]
  end

  def errors
    @errors ||= []
  end

  def valid?
    unless @name.present?
      errors << "Name can't be blank"
      return false
    end

    unless @amount.present?
      errors << "Amount can't be blank"
      return false
    end

    if @amount == "0"
      errors << "Amount can't be 0"
      return false
    end

    true
  end

  def save
    return false unless valid?
    Item.all << self
    true
  end

  def inspect
    { name: name, amount: amount }.inspect
  end

end


class ItemsController < SenroController
  protect_from_forgery

  def create
    @item = Item.new(params["item"])
    if @item.save
      flash[:notice] = "Saved Item successfully"
      redirect_to "/items"
    else
      flash.now[:errors] = @item.errors
      render :new
    end
  end

  def index
    @items = Item.all
    render :index
  end

  def new
    @item = Item.new
    render :new
  end

end

router = Router.new
router.draw do
  get Regexp.new("^/items$"), ItemsController, :index
  get Regexp.new("^/$"), ItemsController, :index
  get Regexp.new("^/items/new$"), ItemsController, :new
  post Regexp.new("^/items$"), ItemsController, :create
end

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  router.run(req, res)
  res.finish
end

app = Rack::Builder.new do
  use Static
  run app
end.to_app

Rack::Server.start(
 app: app,
 Port: 3000
)
