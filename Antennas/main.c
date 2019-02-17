#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct antenna {
    int p;
    int r;
    int lb;
    int ub;
} antenna;

int min_comp (int a, int b) {
    if (a < b) {
        return a;
    } else {
        return b;
    }
}

int max_comp (int a, int b) {
    if (a > b) {
        return a;
    } else {
        return b;
    }
}

void sort (int l, int a, antenna* coll, int* cov) {
    int i;
    int j;
    int k;

    // Recalculate radius (with uncovered)
    for (i = 0; i < a; i += 1) {
        coll[i].r = 0;
        for (j = coll[i].lb; j < coll[i].ub; j += 1) {
            if (cov[j] == 0) {
                coll[i].r += 1;
            }
        }
    }

    // Sort using radius
    for (i = 0; i < a; i += 1) {
        for (k = i + 1; k < a; j += 1) {
            if (coll[i].r > coll[k].r) {
                struct antenna temp;
                temp = coll[i];
                coll[i] = coll[k];
                coll[k] = temp;
            }
        }
    }
}

void remove_redundant (int l, int a, antenna* coll, int* cov) {
    int* r = construct_remove_flag(a);
}

int remove (int a, antenna* coll, int* r) {
    // Iterate over antennas
    for (int i = 0; i < a; i += 1) {
        // If set to remove
        if (r[i] == 1) {
            // replace with last position and reduce array size by one
            struct antenna temp;
            temp = coll[i];
            coll[i] = coll[a - 1];
            coll[a - 1] = temp;
            a -= 1;
        }
    }

    return a;
}

int missing_coverage(int l, int* cov) {
    for (int j = 0; j < l; j += 1) {
        if (cov[j] == 0) {
            return 1;
        }
    }

    return 0;
}

int calculate_removable (int l, int a, antenna* coll, int* cov) {
    int removable = 0;

    int i;
    int j;

    while (missing_coverage(l, cov)) {
        sort(l, a, coll, cov);
        remove_redundant();
        remove_required();
    }

    // Coverage matrix
    int** m = malloc(a * sizeof(int*));

    for (i = 0; i < a; i += 1) {
        m[i] = malloc(l * sizeof(int));
        antenna x = coll[i];
        for (j = 0; j < l; j += 1) {
            m[i][j] = x.lb <= j && j < x.ub ? 1 : 0;
        }
    }

    return removable;
}

int* construct_remove_flag (int a) {
    int* r = malloc(a * sizeof(int));
}

int* construct_coverage (int l, int a, antenna* coll) {
    bool alerted = 0;
    int* cov = malloc(l * sizeof(int));

    for (int j = 0; j < l; j += 1) {
        bool found = 0;

        for (int i = 0; i < a; i += 1) {
            if (coll[i].lb <= j && j < coll[i].ub) {
                found = 1;
                break;
            }
        }

        cov[j] = found ? 1 : 0;

        if (!found && !alerted) {
            alerted = 1;
            printf("La carretera no esta cubierta del todo.\n");
        }
    }

    return cov;
}

antenna* construct_antennas (int l, int a) {
    // Reusable indexes
    int i;

    // Collection
    antenna* coll = malloc(a * sizeof(antenna));

    // Read antenna from stdin
    for (i = 0; i < a; i += 1) {
        int p;
        int r;
        scanf("%d,%d", &p, &r);
        struct antenna x;
        x.p = p;
        x.r = r;
        x.lb = max_comp(p - r, 0);
        x.ub = min_comp(p + r, l);
        coll[i] = x;
    }

    return coll;
}

int main () {
    int l = 0;
    int a = 0;
    while (1) {
        int result = scanf("%d,%d", &l, &a);

        if (result < 2) {
            return 0;
        }

        antenna* coll = construct_antennas(l, a);
        int* cov = construct_coverage(l, a, coll);
        int removable = calculate_removable(l, a, coll, cov);
        printf("%d\n", removable);
    }
}
