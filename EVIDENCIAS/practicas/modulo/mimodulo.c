#include <linux/init.h>
#include <linux/module.h>
#include <linux/utsname.h>

static int __init mimodulo_init(void)
{
    pr_info("mimodulo: cargado en %s\n", utsname()->nodename);
    return 0;
}

static void __exit mimodulo_exit(void)
{
    pr_info("mimodulo: descargado del kernel\n");
}

module_init(mimodulo_init);
module_exit(mimodulo_exit);

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Modulo del TP4 que registra el nombre del equipo");
