# Inicialización del plugin Netcol User Permissions en Redmine
require 'redmine'  # Cargar Redmine

# Cargar los archivos de funcionalidad del plugin
require_dependency 'netcol_user_permissions/hooks'  # Hook para inyectar código en la interfaz
require_dependency 'netcol_user_permissions/user_patch'  # Extensión de permisos en User

# Registrar el plugin en Redmine
Redmine::Plugin.register :netcol_user_permissions do
  name 'Netcol User Permissions'  # Nombre del plugin
  author 'Netcol'  # Autor del plugin
  description 'Maneja permisos personalizados para usuarios en Redmine'  # Descripción corta
  version '1.0.0'  # Versión del plugin
  url 'https://github.com/carlos0424/netcol_user_permissions'  # URL del repositorio
  author_url 'https://github.com/carlos0424'  # URL del autor

  # Configuración por defecto del plugin
  settings default: {
    'export_permission_cf_id' => '28',  # ID del campo personalizado para exportar reportes
    'value_view_cf_id' => '34'  # ID del campo personalizado para ver valores restringidos
  }, partial: 'settings/netcol_settings'  # Permitir configuración desde la interfaz de administración
end
