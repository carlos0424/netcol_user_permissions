module NetcolUserPermissions
  module UserPatch
    def self.included(base)
      base.class_eval do
        attr_accessor :session_data  # Define session_data como un atributo virtual

        # Guardar valores en la sesión al iniciar sesión
        after_save :update_netcol_permissions

        def update_netcol_permissions
          if User.current == self
            self.session_data ||= {}  # Inicializa session_data si es nil
            self.session_data[:netcol_permissions] = {
              can_export_reports: custom_field_value(28).to_s.match(/SI/i).present?,
              can_view_values: custom_field_value(34).to_s.match(/SI/i).present?
            }
          end
        end

        # Métodos de ayuda para consultar permisos
        def can_export_reports?
          session_data&.dig(:netcol_permissions, :can_export_reports) || false
        end

        def can_view_values?
          session_data&.dig(:netcol_permissions, :can_view_values) || false
        end
      end
    end
  end
end

# Extender la clase User
Rails.configuration.to_prepare do
  User.include(NetcolUserPermissions::UserPatch)
end

