# Módulo NetcolUserPermissions: Maneja la inyección de código en la interfaz de Redmine.
module NetcolUserPermissions
  # Clase Hooks: Agrega código HTML y JavaScript en las vistas de Redmine.
  class Hooks < Redmine::Hook::ViewListener

    # Método que se ejecuta en la cabecera HTML de todas las páginas.
    # Inyecta JavaScript para controlar la visibilidad de los botones de exportación.
    def view_layouts_base_html_head(context={})
      user = User.current  # Obtener el usuario actual de la sesión de Redmine.

      # Verificar si el usuario tiene permisos personalizados.
      export_permission = user.can_export_reports?  # Permiso para exportar reportes.
      view_values_permission = user.can_view_values?  # Permiso para ver valores específicos.

      # Inyectar código JavaScript en la página.
      <<-JAVASCRIPT
        <script>
          document.addEventListener("DOMContentLoaded", function() {
            // Variables de permisos recibidas desde Ruby
            var canExportReports = #{export_permission};
            var canViewValues = #{view_values_permission};

            // Si el usuario no tiene permiso para exportar, ocultar los botones de exportación.
            if (!canExportReports) {
              document.querySelectorAll('a.csv, a.pdf, a.xlsx, p.other-formats a.xls, p.other-formats a.xlse')
                      .forEach(el => el.closest('span').style.display = 'none');
            }

            // Si el usuario no tiene permiso para ver valores, ocultar elementos específicos.
            if (!canViewValues) {
              document.querySelectorAll('.restricted-values').forEach(el => el.style.display = 'none');
            }
          });
        </script>
      JAVASCRIPT
    end
  end
end
