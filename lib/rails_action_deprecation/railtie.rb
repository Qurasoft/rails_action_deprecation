module RailsActionDeprecation
  class Railtie < Rails::Railtie
    initializer "rails_action_deprecation.action_controller" do
      ActiveSupport.on_load(:action_controller) do
        include RailsActionDeprecation::Controller
      end
    end
  end
end