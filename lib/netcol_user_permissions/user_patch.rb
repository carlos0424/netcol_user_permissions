module NetcolUserPermissions
  module UserPatch
    def self.included(base)
      base.class_eval do

        # Método para verificar si un usuario tiene permiso para exportar reportes
        def can_export_reports?
          export_permission_cf = CustomField.find_by(id: 28)  # Buscar el campo personalizado
          return false unless export_permission_cf  # Si el campo no existe, devolver false
          custom_field_value(28).to_s.strip.upcase == "SI"  # Verificar si es "SI"
        end

        # Método para verificar si un usuario tiene permiso para ver valores específicos
        def can_view_values?
          view_permission_cf = CustomField.find_by(id: 34)  # Buscar el campo personalizado
          return false unless view_permission_cf  # Si el campo no existe, devolver false
          custom_field_value(34).to_s.strip.upcase == "SI"  # Verificar si es "SI"
        end
      end
    end
  end
end

# Extiende la clase User con el nuevo módulo de permisos
Rails.configuration.to_prepare do
  User.include(NetcolUserPermissions::UserPatch)
end
