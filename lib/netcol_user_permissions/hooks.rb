module NetcolUserPermissions
  class Hooks < Redmine::Hook::ViewListener
    def view_layouts_base_html_head(context={})
      user = User.current

      # Obtener permisos del usuario
      export_permission = user.can_export_reports?
      view_values_permission = user.can_view_values?

      # Inyectar código JavaScript para ocultar todo el bloque si el usuario no tiene permiso
      <<-JAVASCRIPT
        <script>
          document.addEventListener("DOMContentLoaded", function() {
            var canExportReports = #{export_permission};
            var canViewValues = #{view_values_permission};

            console.log("Permiso de exportación:", canExportReports);
            console.log("Permiso de ver valores:", canViewValues);

            // Si el usuario NO tiene permiso, ocultar TODO el bloque de exportación
            if (!canExportReports) {
              document.querySelectorAll('.other-formats').forEach(el => {
                el.style.display = 'none'; // Oculta título y botones
              });
              console.log("Bloque de exportación ocultado");
            }
          });
        </script>
      JAVASCRIPT
    end
  end
end
