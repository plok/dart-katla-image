#ifndef FLUTTER_PLUGIN_DART_KATLA_IMAGE_PLUGIN_H_
#define FLUTTER_PLUGIN_DART_KATLA_IMAGE_PLUGIN_H_

#include <flutter_linux/flutter_linux.h>

G_BEGIN_DECLS

#ifdef FLUTTER_PLUGIN_IMPL
#define FLUTTER_PLUGIN_EXPORT __attribute__((visibility("default")))
#else
#define FLUTTER_PLUGIN_EXPORT
#endif

typedef struct _DartKatlaImagePlugin DartKatlaImagePlugin;
typedef struct {
  GObjectClass parent_class;
} DartKatlaImagePluginClass;

FLUTTER_PLUGIN_EXPORT GType dart_katla_image_plugin_get_type();

FLUTTER_PLUGIN_EXPORT void dart_katla_image_plugin_register_with_registrar(
    FlPluginRegistrar* registrar);

G_END_DECLS

#endif  // FLUTTER_PLUGIN_DART_KATLA_IMAGE_PLUGIN_H_
