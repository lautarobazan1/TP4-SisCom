#define _GNU_SOURCE
#include <signal.h>
#include <stdio.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>

static void manejar_sigsegv(int signo)
{
    static const char mensaje[] = "SIGSEGV capturada\n";

    (void)signo;
    (void)write(STDERR_FILENO, mensaje, sizeof(mensaje) - 1);
    _exit(1);
}

int main(int argc, char **argv)
{
    if (argc == 2 && strcmp(argv[1], "manejar") == 0) {
        struct sigaction accion = {.sa_handler = manejar_sigsegv};
        sigemptyset(&accion.sa_mask);
        if (sigaction(SIGSEGV, &accion, NULL) == -1) {
            perror("sigaction");
            return 2;
        }
    }

    void *pagina = mmap(NULL, 4096, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    if (pagina == MAP_FAILED) {
        perror("mmap");
        return 2;
    }

    *(volatile unsigned char *)pagina = 1;
    return 0;
}
