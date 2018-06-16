#define  __FIRST_ARG_IN_AX__ 1
void put_c(c);
void main() 
{
    static char str[25] = "Load system success!";//`{'L','o','a','d',' ','s','y','s','t','e','m',' ','s','u','c','c','e','s','s','!'};
    int i;
    i = 0;
    while (1) {
        if (str[i] != 0)
            put_c(str[i]);
        else
            break;
        ++i;
    }
    while (1) {}    // Idle
}

void put_c(c) 
    char c;
{
#asm
    mov ah, #0x0e
    mov bx, #0x0007
    int 0x10
#endasm
}

