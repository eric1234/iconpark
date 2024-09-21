class Iconpark::Engine < Rails::Engine
  initializer "iconpark.helpers" do
    ActiveSupport.on_load(:action_view) { include Iconpark::Helpers }
  end
end
