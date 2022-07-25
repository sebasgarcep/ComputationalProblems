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


bool is_prime(ll n) {
    if ((n & 1) == 0) {
        return n == 2;
    }
    for (ll d = 3; d * d <= n; d += 2) {
        if (n % d == 0) {
            return false;
        }
    }
    return true;
}

void calculate_inverse_mod(ll* imm, ll p, ll m) {
    imm[0] = 0; // This value should never be used.
    for (ll k = 1; k <= m; k += 1) {
        imm[k] = invmod(k, p);
    }
}

void calculate_internal_power_mod(ll* pmm, ll p, ll m, ll n) {
    pmm[0] = 1;
    for (ll k = 1; k <= m; k += 1) {
        pmm[k] = powermod(n, k, p);
    }
}

void calculate_mod_bernoulli_numbers(ll* imm, ll* mbn, ll p, ll n) {
    mbn[0] = 1;
    for (ll r = 1; r <= n; r += 1) {
        ll partial_sum = 0;
        ll binom_acc = 1;
        for (ll k = 0; k <= r - 1; k += 1) {
            ll term = mbn[k];
            term = mod(term * binom_acc, p);
            partial_sum = mod(partial_sum + term, p);
            binom_acc = mod(binom_acc * (r + 1 - k), p);
            binom_acc = mod(binom_acc * imm[k + 1], p);
        }
        mbn[r] = mod(-partial_sum * imm[r + 1], p);
    }
}

ll f(ll* imm, ll* pmm, ll* mbn, ll p, ll m) {
    ll result = imm[m + 1] * (pmm[m + 1] - 1);
    result = mod(result, p);
    ll binom_acc = 1;
    for (ll k = 1; k <= m; k += 1) {
        ll term = mbn[k];
        term = mod(term * imm[k], p);
        term = mod(term * binom_acc, p);
        term = mod(term * (pmm[m + 1 - k] - 1), p);
        result = mod(result + term, p);
        binom_acc = mod(binom_acc * (m + 1 - k), p);
        binom_acc = mod(binom_acc * imm[k], p);
    }
    return result;
}

ll s(ll* imm, ll* pmm, ll* mbn, ll p, ll m, ll n) {
    ll result = imm[m + 1] * (f(imm, pmm, mbn, p, m + 1) - mod(n, p) - 1);
    result = mod(result, p);
    ll binom_acc = 1;
    for (ll k = 1; k <= m; k += 1) {
        ll term = mbn[k];
        term = mod(term * imm[k], p);
        term = mod(term * binom_acc, p);
        term = mod(term * (f(imm, pmm, mbn, p, m + 1 - k) - mod(n, p) - 1), p);
        result = mod(result + term, p);
        binom_acc = mod(binom_acc * (m + 1 - k), p);
        binom_acc = mod(binom_acc * imm[k], p);
    }
    return result;
}

// Problem parameters
ll p_min = 2 * 1000000000;
ll p_max = 2 * 1000000000 + 2000;
ll m = 10000;
ll n = 1000000000000;

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
    ll* imm = new ll[m + 3];
    ll* pmm = new ll[m + 3];
    ll* mbn = new ll[m + 3];

    for (ll p = p_min; p <= p_max; p += 1) {
        if (!is_prime(p)) {
            continue;
        }
        printf("%lld\n", p);

        // Inverse mod cache
        calculate_inverse_mod(imm, p, m + 2);
        // Internal calculation of S_m(n) will use
        // repeated instances of (n+2) to some power.
        // Calculate all such powers.
        calculate_internal_power_mod(pmm, p, m + 2, n + 2);
        // Bernoulli numbers cache
        calculate_mod_bernoulli_numbers(imm, mbn, p, m + 2);

        result += s(imm, pmm, mbn, p, m, n);
    }

    // Show result
    printf("%lld\n", result);

    // End time measurement
    stop = std::chrono::high_resolution_clock::now();
    elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count() / 1000.0;
    printf("Took: %lf\n", elapsed);
}
