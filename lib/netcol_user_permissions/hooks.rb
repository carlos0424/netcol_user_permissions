module NetcolUserPermissions
  class Hooks < Redmine::Hook::ViewListener
    def view_layouts_base_html_head(context={})
      user = User.current

      # Obtener permisos del usuario
      export_permission = user.can_export_reports?
      view_values_permission = user.can_view_values?

      # Inyectar código JavaScript para mostrar los botones de exportación si el usuario tiene permiso
      <<-JAVASCRIPT
        <script>
          document.addEventListener("DOMContentLoaded", function() {
            var canExportReports = #{export_permission};
            var canViewValues = #{view_values_permission};

            console.log("Permiso de exportación:", canExportReports);
            console.log("Permiso de ver valores:", canViewValues);

            // Asegurar que los botones sean visibles si el usuario tiene permiso
            if (canExportReports) {
              document.querySelectorAll('a.xls, a.xlse').forEach(el => {
                if (el.closest('span')) {
                  el.closest('span').style.display = 'inline'; // Mostrar el botón
                }
                console.log("Mostrando botón de exportación:", el);
              });
            }
          });
        </script>
      JAVASCRIPT
    end
  end
end
