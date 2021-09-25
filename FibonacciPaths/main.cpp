#include <chrono>
#include <math.h>
#include <stdio.h>
#include <set>
#include <vector>
#include <algorithm>

// Problem parameters
const long n = 10000;
const long m = 10000;
const long mod_size = 1000000000 + 7;

// Algorithm parameters

// Static variables

long mod(long a, long b) {
    long r = a % b;
    return r >= 0 ? r : r + b;
}

long isqrt(long n) {
    long t = (long) sqrt(n);
    if ((t + 1) * (t + 1) <= n) {
        return t + 1;
    } else if (t * t <= n) {
        return t;
    } else {
        return t - 1;
    }
}

long icbrt(long n) {
    long t = (long) cbrt(n);
    if ((t + 1) * (t + 1) * (t + 1) <= n) {
        return t + 1;
    } else if (t * t * t <= n) {
        return t;
    } else {
        return t - 1;
    }
}

long iroot(long x, long n) {
    if (n == 1) {
        return x;
    } else if (n == 2) {
        return isqrt(x);
    } else if (n == 3) {
        return icbrt(x);
    } else {
        long test = (long) pow(x, 1.0 / n);
        if (pow(test + 1, n) <= x) {
            return test + 1;
        } else {
            return test;
        }
    }
}

bool compare_tuple(std::pair<long, long> t1, std::pair<long, long> t2) {
    return (t1.first + t1.second) < (t2.first + t2.second);
}

int main() {
    // Begin time measurement
    std::chrono::high_resolution_clock::time_point start;
    std::chrono::high_resolution_clock::time_point stop;
    double elapsed;
    start = std::chrono::high_resolution_clock::now();

    // Problem result
    long result = 0;

    // Solution
    std::set<long> fibonacci_sq;

    long a = 1;
    long b = 1;
    while (b * b <= n * n + m * m) {
        fibonacci_sq.insert(b * b);
        long t = a + b;
        a = b;
        b = t;
    }

    std::vector<std::pair<long, long>> paths;
    for (long x = 1; x <= isqrt(n * n + m * m); x += 1) {
        for (long y = 0; y <= x - 1; y += 1) {
            if (x * x + y * y > n * n + m * m) {
                break;
            }
            if (fibonacci_sq.count(x * x + y * y) > 0) {
                paths.push_back(std::pair<long, long>(x, y));
                paths.push_back(std::pair<long, long>(y, x));
            }
        }
    }
    sort(paths.begin(), paths.end(), compare_tuple);

    auto f_memo = new long[n + 1][m + 1];

    for (long d = 0; d <= n + m; d += 1) {
        for (long h = std::max(0l, d - n); h <= std::min(m, d); h += 1) {
            long w = d - h;
            if (w == 0 && h == 0) {
                f_memo[w][h] = 1;
            } else if (h > w) {
                f_memo[w][h] = f_memo[h][w];
            } else {
                for (auto t : paths) {
                    long x = t.first;
                    long y = t.second;
                    if (x + y > w + h) {
                        break;
                    }
                    if (w - x < 0 || h - y < 0) {
                        continue;
                    }
                    f_memo[w][h] += f_memo[w - x][h - y];
                }
                f_memo[w][h] %= mod_size;
            }
        }
    }

    result = f_memo[n][m];

    // Show result
    printf("%ld\n", result);

    // End time measurement
    stop = std::chrono::high_resolution_clock::now();
    elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count() / 1000.0;
    printf("Took: %lf\n", elapsed);
}
