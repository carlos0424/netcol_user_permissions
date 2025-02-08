before_action :check_export_permission, only: [:xls_export_current, :xls_export]

private

def check_export_permission
  unless User.current.can_export_reports?
    render plain: "Acceso denegado", status: 403
  end
end
