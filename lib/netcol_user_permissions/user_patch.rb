# Módulo NetcolUserPermissions: Extiende la funcionalidad de los usuarios en Redmine
module NetcolUserPermissions
  module UserPatch
    def self.included(base)
      base.class_eval do
        
        # Método para verificar si un usuario tiene permiso para exportar reportes.
        # Se obtiene el valor del campo personalizado con ID 28 y se verifica si es "SI".
        def can_export_reports?
          export_permission_cf = CustomField.find_by(id: 28) # Buscar el campo personalizado
          export_permission_cf ? custom_field_value(28).to_s.match(/SI/i).present? : false
        end

        # Método para verificar si un usuario tiene permiso para ver valores específicos.
        # Se obtiene el valor del campo personalizado con ID 34 y se verifica si es "SI".
        def can_view_values?
          view_permission_cf = CustomField.find_by(id: 34) # Buscar el campo personalizado
          view_permission_cf ? custom_field_value(34).to_s.match(/SI/i).present? : false
        end
      end
    end
  end
end

# Extiende la clase User con el nuevo módulo de permisos.
# Esto asegura que todos los usuarios en Redmine tengan acceso a estos métodos.
Rails.configuration.to_prepare do
  User.include(NetcolUserPermissions::UserPatch)
end
