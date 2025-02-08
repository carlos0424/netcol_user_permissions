before_action :check_export_permission, only: [:xls_export, :xls_export_current]

private

# Método que verifica si el usuario tiene permiso para exportar reportes
def check_export_permission
  unless User.current.can_export_reports?
    render plain: "Acceso denegado", status: 403
  end
end
