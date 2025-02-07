module NetcolUserPermissions
  class Hooks < Redmine::Hook::ViewListener
    def view_layouts_base_html_head(context={})
      user = User.current
      
      # Obtener los permisos
      export_permission = user.custom_field_value(28).to_s.match(/SI/i).present?
      view_values_permission = user.custom_field_value(34).to_s.match(/SI/i).present?
      
      # Agregar JavaScript para controlar permisos
      <<-JAVASCRIPT
        <script>
          window.NETCOL_PERMISSIONS = {
            canExportReports: #{export_permission},
            canViewValues: #{view_values_permission}
          };

          $(document).ready(function() {
            if (!window.NETCOL_PERMISSIONS.canExportReports) {
              // Ocultar botones de exportación
              $('a.csv, a.pdf, a.xlsx').parent('span').hide();
              $('p.other-formats a.xls, p.other-formats a.xlse').parent('span').hide();
            }
          });
        </script>
      JAVASCRIPT
    end
  end
end
