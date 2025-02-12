#include <chrono>
#include <math.h>
#include <stdio.h>

typedef long long ll;

constexpr ll mod(ll a, ll b) {
    ll r = a % b;
    return r >= 0 ? r : r + b;
}

ll invmod(ll a, ll b)
{
	ll b0 = b, t, q;
	ll x0 = 0, x1 = 1;
	if (b == 1) return 1;
	while (a > 1) {
		q = a / b;
		t = b, b = a % b, a = t;
		t = x0, x0 = x1 - q * x0, x1 = t;
	}
	if (x1 < 0) x1 += b0;
	return x1;
}

ll powermod(ll base, ll exp, ll modulus) {
  base %= modulus;
  ll result = 1;
  while (exp > 0) {
    if (exp & 1) result = (result * base) % modulus;
    base = (base * base) % modulus;
    exp >>= 1;
  }
  return result;
}

constexpr ll isqrt(ll x) {
    ll q = 1;
    while (q <= x)
        q <<= 2;
    ll r = 0;
    while (q > 1) {
        q >>= 2;
        ll t = x - r - q;
        r >>= 1;
        if (t >= 0) {
            x = t;
            r += q;
        }
    }
    return r;
}

constexpr ll icbrt(ll n) {
    ll t = (ll) cbrt(n);
    if ((t + 1) * (t + 1) * (t + 1) <= n) {
        return t + 1;
    } else if (t * t * t <= n) {
        return t;
    } else {
        return t - 1;
    }
}

ll iroot(ll x, ll n) {
    if (n == 1) {
        return x;
    } else if (n == 2) {
        return isqrt(x);
    } else if (n == 3) {
        return icbrt(x);
    } else {
        ll test = (ll) pow(x, 1.0 / n);
        if (pow(test + 1, n) <= x) {
            return test + 1;
        } else {
            return test;
        }
    }
}

// Problem parameters

// Algorithm parameters

// Static variables

int main() {
    // Begin time measurement
    std::chrono::high_resolution_clock::time_point start;
    std::chrono::high_resolution_clock::time_point stop;
    double elapsed;
    start = std::chrono::high_resolution_clock::now();

    // Problem result
    ll result = 0;

    // Solution

    // Show result
    printf("%lld\n", result);

    // End time measurement
    stop = std::chrono::high_resolution_clock::now();
    elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count() / 1000.0;
    printf("Took: %lf\n", elapsed);
}
