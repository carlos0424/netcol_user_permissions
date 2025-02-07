require 'redmine'
require_dependency 'netcol_user_permissions/hooks'
require_dependency 'netcol_user_permissions/user_patch'

Redmine::Plugin.register :netcol_user_permissions do
  name 'Netcol User Permissions'
  author 'Netcol'
  description 'Maneja permisos personalizados para usuarios de Netcol'
  version '1.0.0'
  
  # Configuración por defecto
  settings default: {
    'export_permission_cf_id' => '28',  # ID campo exportar reportes
    'value_view_cf_id' => '34'   # ID campo ver valores LPU
  }
end
