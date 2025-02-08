module NetcolUserPermissions
  class Hooks < Redmine::Hook::ViewListener
    def view_layouts_base_html_head(context={})
      user = User.current

      # Obtener permisos del usuario
      export_permission = user.can_export_reports?
      view_values_permission = user.can_view_values?

      # Inyectar código JavaScript para ocultar los botones si el usuario no tiene permisos
      <<-JAVASCRIPT
        <script>
          document.addEventListener("DOMContentLoaded", function() {
            var canExportReports = #{export_permission};
            var canViewValues = #{view_values_permission};

            console.log("Permiso de exportación:", canExportReports);
            console.log("Permiso de ver valores:", canViewValues);

            // Si el usuario NO tiene permiso, ocultar los botones de exportación
            if (!canExportReports) {
              document.querySelectorAll('a.xls, a.xlse').forEach(el => {
                if (el.closest('span')) {
                  el.closest('span').style.display = 'none'; // Ocultar
                }
                console.log("Ocultando botón de exportación:", el);
              });
            }
          });
        </script>
      JAVASCRIPT
    end
  end
end
