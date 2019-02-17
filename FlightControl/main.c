#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct plane {
    double radius;
    double speed;
    int k;
    double** route;
} plane;

const double tol = 1e-10;
double* endpoint;

double min_comp (double a, double b) {
    if (a < b) {
        return a;
    } else {
        return b;
    }
}

double max_comp (double a, double b) {
    if (a > b) {
        return a;
    } else {
        return b;
    }
}

double diff_dot_product_3d (double* r1, double* r2, double* s1, double* s2) {
    return
        (r1[0] - r2[0]) * (s1[0] - s2[0]) +
        (r1[1] - r2[1]) * (s1[1] - s2[1]) +
        (r1[2] - r2[2]) * (s1[2] - s2[2]);
}

double point_distance_sq_3d (double* p1, double* p2) {
    return diff_dot_product_3d(p1, p2, p1, p2);
}

double point_distance_3d (double* p1, double* p2) {
    return sqrt(point_distance_sq_3d(p1, p2));
}

bool point_equal_1d (double p1, double p2) {
    return fabs(p1 - p2) <= tol;
}

bool point_equal_3d (double* p1, double* p2) {
    return point_distance_3d(p1, p2) <= tol;
}

plane construct_plane () {
    struct plane p;
    scanf("%lf %lf %d", &(p.radius), &(p.speed), &(p.k));
    p.route = (double**) malloc((p.k + 1) * sizeof(double*));
    int line_idx;
    for (line_idx = 0; line_idx < p.k; line_idx += 1) {
        double* route_pos = (double*) malloc(3 * sizeof(double));
        scanf("%lf %lf %lf", &(route_pos[0]), &(route_pos[1]), &(route_pos[2]));
        p.route[line_idx] = route_pos;
    }
    p.route[p.k] = endpoint;
   return p;
}

void fill_auxiliary_data (double* t, double** sv, double* pf, double* pi, double speed) {
    double d = point_distance_3d(pf, pi);
    *t = d / speed;
    (*sv)[0] = (pf[0] - pi[0]) / *t;
    (*sv)[1] = (pf[1] - pi[1]) / *t;
    (*sv)[2] = (pf[2] - pi[2]) / *t;
}

bool spheres_collide (double* p1, double r1, double* p2, double r2) {
    return point_distance_sq_3d(p1, p2) - (r1 + r2) * (r1 + r2) <= tol;
}

void propagate_model (double** r, double* p, double* s, double t) {
    (*r)[0] = p[0] + t * s[0];
    (*r)[1] = p[1] + t * s[1];
    (*r)[2] = p[2] + t * s[2];
}

void update_initial_final_points (plane p, int idx, double** pi, double** pf) {
    *pi = p.route[idx];
    *pf = p.route[idx + 1];
}

int calculate_collisions (plane p1, plane p2) {
    int collisions = 0;

    int idx1 = 0;
    double* piv1;
    double* pfv1;
    double t1;
    double* sv1 = (double*) malloc(3 * sizeof(double));
    double* r1 = (double*) malloc(3 * sizeof(double));
    update_initial_final_points(p1, idx1, &piv1, &pfv1);

    int idx2 = 0;
    double* piv2;
    double* pfv2;
    double t2;
    double* sv2 = (double*) malloc(3 * sizeof(double));
    double* r2 = (double*) malloc(3 * sizeof(double));
    update_initial_final_points(p2, idx2, &piv2, &pfv2);

    bool is_colliding = spheres_collide(piv1, p1.radius, piv2, p2.radius);
    if (is_colliding) {
        collisions += 1;
    }

    do {
        fill_auxiliary_data(&t1, &sv1, pfv1, piv1, p1.speed);
        fill_auxiliary_data(&t2, &sv2, pfv2, piv2, p2.speed);

        double tmax = min_comp(t1, t2);
        propagate_model(&r1, piv1, sv1, tmax);
        pfv1 = r1;
        propagate_model(&r2, piv2, sv2, tmax);
        pfv2 = r2;

        bool final_point_collision = spheres_collide(pfv1, p1.radius, pfv2, p2.radius);

        if (!point_equal_3d(sv1, sv2)) {
            if (!final_point_collision) {
                double topt;
                topt = - diff_dot_product_3d(piv1, piv2, sv1, sv2) / point_distance_sq_3d(sv1, sv2);
                topt = min_comp(max_comp(topt, 0.0), tmax);
                propagate_model(&r1, piv1, sv1, topt);
                propagate_model(&r2, piv2, sv2, topt);
                if (spheres_collide(r1, p1.radius, r2, p2.radius)) {
                    collisions += 1;
                }
            } else if (!is_colliding) {
                collisions += 1;
            }
        }

        if (point_equal_1d(t1, t2)) {
            idx1 += 1;
            update_initial_final_points(p1, idx1, &piv1, &pfv1);
            idx2 += 1;
            update_initial_final_points(p2, idx2, &piv2, &pfv2);
        } else if (t1 > t2) {
            piv1 = pfv1;
            idx2 += 1;
            update_initial_final_points(p2, idx2, &piv2, &pfv2);
        } else {
            idx1 += 1;
            update_initial_final_points(p1, idx1, &piv1, &pfv1);
            piv2 = pfv2;
        }

        is_colliding = final_point_collision;
    } while (p1.k > idx1 && p2.k > idx2);

    return collisions;
}

int main () {
    endpoint = (double*) malloc(3 * sizeof(double));
    endpoint[0] = 0.0;
    endpoint[1] = 0.0;
    endpoint[2] = 0.0;

    int num_test_cases;
    scanf("%d", &num_test_cases);
    int iter_idx;
    for (iter_idx = 0; iter_idx < num_test_cases; iter_idx += 1) {
        plane p1 = construct_plane();
        plane p2 = construct_plane();
        int collisions = calculate_collisions(p1, p2);
        printf("%d\n", collisions);
    }
    return 0;
}
