module RackPhantom
  class Railtie < Rails::Railtie
    initializer "rack_phantom.configure_rails_initialization" do |app|
      app.middleware.use RackPhantom::Middleware
    end
  end
end