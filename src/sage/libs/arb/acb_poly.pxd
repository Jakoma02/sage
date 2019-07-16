# distutils: libraries = gmp flint arb
# distutils: depends = acb_poly.h

from sage.libs.arb.types cimport *
from sage.libs.flint.types cimport fmpz_poly_t, fmpq_poly_t

# acb_poly.h
cdef extern from "arb_wrap.h":
    void acb_poly_init(acb_poly_t poly)
    void acb_poly_clear(acb_poly_t poly)
    void acb_poly_fit_length(acb_poly_t poly, long len)
    void _acb_poly_set_length(acb_poly_t poly, long len)
    void _acb_poly_normalise(acb_poly_t poly)
    void acb_poly_swap(acb_poly_t poly1, acb_poly_t poly2)
    long acb_poly_length(const acb_poly_t poly)
    long acb_poly_degree(const acb_poly_t poly)
    bint acb_poly_is_zero(const acb_poly_t poly)
    bint acb_poly_is_one(const acb_poly_t poly)
    bint acb_poly_is_x(const acb_poly_t poly)
    void acb_poly_zero(acb_poly_t poly)
    void acb_poly_one(acb_poly_t poly)
    void acb_poly_set(acb_poly_t dest, const acb_poly_t src)
    void acb_poly_set_round(acb_poly_t dest, const acb_poly_t src, long prec)
    void acb_poly_set_coeff_si(acb_poly_t poly, long n, long c)
    void acb_poly_set_coeff_acb(acb_poly_t poly, long n, const acb_t c)
    void acb_poly_get_coeff_acb(acb_t v, const acb_poly_t poly, long n)
    acb_ptr acb_poly_get_coeff_ptr(acb_poly_t, long)
    void _acb_poly_shift_right(acb_ptr res, acb_srcptr poly, long len, long n)
    void acb_poly_shift_right(acb_poly_t res, const acb_poly_t poly, long n)
    void _acb_poly_shift_left(acb_ptr res, acb_srcptr poly, long len, long n)
    void acb_poly_shift_left(acb_poly_t res, const acb_poly_t poly, long n)
    void acb_poly_truncate(acb_poly_t poly, long n)
    void acb_poly_printd(const acb_poly_t poly, long digits)
    # void acb_poly_fprintd(FILE * file, const acb_poly_t poly, long digits)
    # void acb_poly_randtest(acb_poly_t poly, flint_rand_t state, long len, long prec, long mag_bits)
    bint acb_poly_equal(const acb_poly_t A, const acb_poly_t B)
    bint acb_poly_contains(const acb_poly_t poly1, const acb_poly_t poly2)
    bint acb_poly_contains_fmpz_poly(const acb_poly_t poly1, const fmpz_poly_t poly2)
    bint acb_poly_contains_fmpq_poly(const acb_poly_t poly1, const fmpq_poly_t poly2)
    bint _acb_poly_overlaps(acb_srcptr poly1, long len1, acb_srcptr poly2, long len2)
    bint acb_poly_overlaps(const acb_poly_t poly1, const acb_poly_t poly2)
    bint acb_poly_get_unique_fmpz_poly(fmpz_poly_t z, const acb_poly_t x)
    bint acb_poly_is_real(const acb_poly_t poly)
    void acb_poly_set_fmpz_poly(acb_poly_t poly, const fmpz_poly_t re, long prec)
    void acb_poly_set2_fmpz_poly(acb_poly_t poly, const fmpz_poly_t re, const fmpz_poly_t im, long prec)
    # void acb_poly_set_arb_poly(acb_poly_t poly, const arb_poly_t re)
    # void acb_poly_set2_arb_poly(acb_poly_t poly, const arb_poly_t re, const arb_poly_t im)
    void acb_poly_set_fmpq_poly(acb_poly_t poly, const fmpq_poly_t re, long prec)
    void acb_poly_set2_fmpq_poly(acb_poly_t poly, const fmpq_poly_t re, const fmpq_poly_t im, long prec)
    void acb_poly_set_acb(acb_poly_t poly, long src)
    void acb_poly_set_si(acb_poly_t poly, long src)
    # void _acb_poly_majorant(arb_ptr res, acb_srcptr poly, long len, long prec)
    # void acb_poly_majorant(arb_poly_t res, const acb_poly_t poly, long prec)
    void _acb_poly_add(acb_ptr C, acb_srcptr A, long lenA, acb_srcptr B, long lenB, long prec)
    void acb_poly_add(acb_poly_t C, const acb_poly_t A, const acb_poly_t B, long prec)
    void acb_poly_add_si(acb_poly_t C, const acb_poly_t A, long B, long prec)
    void _acb_poly_sub(acb_ptr C, acb_srcptr A, long lenA, acb_srcptr B, long lenB, long prec)
    void acb_poly_sub(acb_poly_t C, const acb_poly_t A, const acb_poly_t B, long prec)
    void acb_poly_neg(acb_poly_t C, const acb_poly_t A)
    void acb_poly_scalar_mul_2exp_si(acb_poly_t C, const acb_poly_t A, long c)
    void acb_poly_scalar_mul(acb_poly_t C, const acb_poly_t A, const acb_t c, long prec)
    void acb_poly_scalar_div(acb_poly_t C, const acb_poly_t A, const acb_t c, long prec)
    void _acb_poly_mullow_classical(acb_ptr C, acb_srcptr A, long lenA, acb_srcptr B, long lenB, long n, long prec)
    void _acb_poly_mullow_transpose(acb_ptr C, acb_srcptr A, long lenA, acb_srcptr B, long lenB, long n, long prec)
    void _acb_poly_mullow_transpose_gauss(acb_ptr C, acb_srcptr A, long lenA, acb_srcptr B, long lenB, long n, long prec)
    void _acb_poly_mullow(acb_ptr C, acb_srcptr A, long lenA, acb_srcptr B, long lenB, long n, long prec)
    void acb_poly_mullow_classical(acb_poly_t C, const acb_poly_t A, const acb_poly_t B, long n, long prec)
    void acb_poly_mullow_transpose(acb_poly_t C, const acb_poly_t A, const acb_poly_t B, long n, long prec)
    void acb_poly_mullow_transpose_gauss(acb_poly_t C, const acb_poly_t A, const acb_poly_t B, long n, long prec)
    void acb_poly_mullow(acb_poly_t C, const acb_poly_t A, const acb_poly_t B, long n, long prec)
    void _acb_poly_mul(acb_ptr C, acb_srcptr A, long lenA, acb_srcptr B, long lenB, long prec)
    void acb_poly_mul(acb_poly_t C, const acb_poly_t A1, const acb_poly_t B2, long prec)
    void _acb_poly_inv_series(acb_ptr Qinv, acb_srcptr Q, long Qlen, long len, long prec)
    void acb_poly_inv_series(acb_poly_t Qinv, const acb_poly_t Q, long n, long prec)
    void  _acb_poly_div_series(acb_ptr Q, acb_srcptr A, long Alen, acb_srcptr B, long Blen, long n, long prec)
    void acb_poly_div_series(acb_poly_t Q, const acb_poly_t A, const acb_poly_t B, long n, long prec)
    void _acb_poly_div(acb_ptr Q, acb_srcptr A, long lenA, acb_srcptr B, long lenB, long prec)
    void _acb_poly_rem(acb_ptr R, acb_srcptr A, long lenA, acb_srcptr B, long lenB, long prec)
    void _acb_poly_divrem(acb_ptr Q, acb_ptr R, acb_srcptr A, long lenA, acb_srcptr B, long lenB, long prec)
    bint acb_poly_divrem(acb_poly_t Q, acb_poly_t R, const acb_poly_t A, const acb_poly_t B, long prec)
    void _acb_poly_div_root(acb_ptr Q, acb_t R, acb_srcptr A, long len, const acb_t c, long prec)
    void _acb_poly_taylor_shift_horner(acb_ptr g, const acb_t c, long n, long prec)
    void acb_poly_taylor_shift_horner(acb_poly_t g, const acb_poly_t f, const acb_t c, long prec)
    void _acb_poly_taylor_shift_divconquer(acb_ptr g, const acb_t c, long n, long prec)
    void acb_poly_taylor_shift_divconquer(acb_poly_t g, const acb_poly_t f, const acb_t c, long prec)
    void _acb_poly_taylor_shift_convolution(acb_ptr g, const acb_t c, long n, long prec)
    void acb_poly_taylor_shift_convolution(acb_poly_t g, const acb_poly_t f, const acb_t c, long prec)
    void _acb_poly_taylor_shift(acb_ptr g, const acb_t c, long n, long prec)
    void acb_poly_taylor_shift(acb_poly_t g, const acb_poly_t f, const acb_t c, long prec)
    void _acb_poly_compose_horner(acb_ptr res, acb_srcptr poly1, long len1, acb_srcptr poly2, long len2, long prec)
    void acb_poly_compose_horner(acb_poly_t res, const acb_poly_t poly1, const acb_poly_t poly2, long prec)
    void _acb_poly_compose_divconquer(acb_ptr res, acb_srcptr poly1, long len1, acb_srcptr poly2, long len2, long prec)
    void acb_poly_compose_divconquer(acb_poly_t res, const acb_poly_t poly1, const acb_poly_t poly2, long prec)
    void _acb_poly_compose(acb_ptr res, acb_srcptr poly1, long len1, acb_srcptr poly2, long len2, long prec)
    void acb_poly_compose(acb_poly_t res, const acb_poly_t poly1, const acb_poly_t poly2, long prec)
    void _acb_poly_compose_series_horner(acb_ptr res, acb_srcptr poly1, long len1, acb_srcptr poly2, long len2, long n, long prec)
    void acb_poly_compose_series_horner(acb_poly_t res, const acb_poly_t poly1, const acb_poly_t poly2, long n, long prec)
    void _acb_poly_compose_series_brent_kung(acb_ptr res, acb_srcptr poly1, long len1, acb_srcptr poly2, long len2, long n, long prec)
    void acb_poly_compose_series_brent_kung(acb_poly_t res, const acb_poly_t poly1, const acb_poly_t poly2, long n, long prec)
    void _acb_poly_compose_series(acb_ptr res, acb_srcptr poly1, long len1, acb_srcptr poly2, long len2, long n, long prec)
    void acb_poly_compose_series(acb_poly_t res, const acb_poly_t poly1, const acb_poly_t poly2, long n, long prec)
    void _acb_poly_revert_series_lagrange(acb_ptr h, acb_srcptr f, long flen, long n, long prec)
    void acb_poly_revert_series_lagrange(acb_poly_t h, const acb_poly_t f, long n, long prec)
    void _acb_poly_revert_series_newton(acb_ptr h, acb_srcptr f, long flen, long n, long prec)
    void acb_poly_revert_series_newton(acb_poly_t h, const acb_poly_t f, long n, long prec)
    void _acb_poly_revert_series_lagrange_fast(acb_ptr h, acb_srcptr f, long flen, long n, long prec)
    void acb_poly_revert_series_lagrange_fast(acb_poly_t h, const acb_poly_t f, long n, long prec)
    void _acb_poly_revert_series(acb_ptr h, acb_srcptr f, long flen, long n, long prec)
    void acb_poly_revert_series(acb_poly_t h, const acb_poly_t f, long n, long prec)
    void _acb_poly_evaluate_horner(acb_t y, acb_srcptr f, long len, const acb_t x, long prec)
    void acb_poly_evaluate_horner(acb_t y, const acb_poly_t f, const acb_t x, long prec)
    void _acb_poly_evaluate_rectangular(acb_t y, acb_srcptr f, long len, const acb_t x, long prec)
    void acb_poly_evaluate_rectangular(acb_t y, const acb_poly_t f, const acb_t x, long prec)
    void _acb_poly_evaluate(acb_t y, acb_srcptr f, long len, const acb_t x, long prec)
    void acb_poly_evaluate(acb_t y, const acb_poly_t f, const acb_t x, long prec)
    void _acb_poly_evaluate2_horner(acb_t y, acb_t z, acb_srcptr f, long len, const acb_t x, long prec)
    void acb_poly_evaluate2_horner(acb_t y, acb_t z, const acb_poly_t f, const acb_t x, long prec)
    void _acb_poly_evaluate2_rectangular(acb_t y, acb_t z, acb_srcptr f, long len, const acb_t x, long prec)
    void acb_poly_evaluate2_rectangular(acb_t y, acb_t z, const acb_poly_t f, const acb_t x, long prec)
    void _acb_poly_evaluate2(acb_t y, acb_t z, acb_srcptr f, long len, const acb_t x, long prec)
    void acb_poly_evaluate2(acb_t y, acb_t z, const acb_poly_t f, const acb_t x, long prec)
    void _acb_poly_product_roots(acb_ptr poly, acb_srcptr xs, long n, long prec)
    void acb_poly_product_roots(acb_poly_t poly, acb_srcptr xs, long n, long prec)
    acb_ptr * _acb_poly_tree_alloc(long len)
    void _acb_poly_tree_free(acb_ptr * tree, long len)
    void _acb_poly_tree_build(acb_ptr * tree, acb_srcptr roots, long len, long prec)
    void _acb_poly_evaluate_vec_iter(acb_ptr ys, acb_srcptr poly, long plen, acb_srcptr xs, long n, long prec)
    void acb_poly_evaluate_vec_iter(acb_ptr ys, const acb_poly_t poly, acb_srcptr xs, long n, long prec)
    void _acb_poly_evaluate_vec_fast_precomp(acb_ptr vs, acb_srcptr poly, long plen, acb_ptr * tree, long len, long prec)
    void _acb_poly_evaluate_vec_fast(acb_ptr ys, acb_srcptr poly, long plen, acb_srcptr xs, long n, long prec)
    void acb_poly_evaluate_vec_fast(acb_ptr ys, const acb_poly_t poly, acb_srcptr xs, long n, long prec)
    void _acb_poly_interpolate_newton(acb_ptr poly, acb_srcptr xs, acb_srcptr ys, long n, long prec)
    void acb_poly_interpolate_newton(acb_poly_t poly, acb_srcptr xs, acb_srcptr ys, long n, long prec)
    void _acb_poly_interpolate_barycentric(acb_ptr poly, acb_srcptr xs, acb_srcptr ys, long n, long prec)
    void acb_poly_interpolate_barycentric(acb_poly_t poly, acb_srcptr xs, acb_srcptr ys, long n, long prec)
    void _acb_poly_interpolation_weights(acb_ptr w, acb_ptr * tree, long len, long prec)
    void _acb_poly_interpolate_fast_precomp(acb_ptr poly, acb_srcptr ys, acb_ptr * tree, acb_srcptr weights, long len, long prec)
    void _acb_poly_interpolate_fast(acb_ptr poly, acb_srcptr xs, acb_srcptr ys, long len, long prec)
    void acb_poly_interpolate_fast(acb_poly_t poly, acb_srcptr xs, acb_srcptr ys, long n, long prec)
    void _acb_poly_derivative(acb_ptr res, acb_srcptr poly, long len, long prec)
    void acb_poly_derivative(acb_poly_t res, const acb_poly_t poly, long prec)
    void _acb_poly_integral(acb_ptr res, acb_srcptr poly, long len, long prec)
    void acb_poly_integral(acb_poly_t res, const acb_poly_t poly, long prec)
    void _acb_poly_pow_ui_trunc_binexp(acb_ptr res, acb_srcptr f, long flen, unsigned long exp, long len, long prec)
    void acb_poly_pow_ui_trunc_binexp(acb_poly_t res, const acb_poly_t poly, unsigned long exp, long len, long prec)
    void _acb_poly_pow_ui(acb_ptr res, acb_srcptr f, long flen, unsigned long exp, long prec)
    void acb_poly_pow_ui(acb_poly_t res, const acb_poly_t poly, unsigned long exp, long prec)
    void _acb_poly_pow_series(acb_ptr h, acb_srcptr f, long flen, acb_srcptr g, long glen, long len, long prec)
    void acb_poly_pow_series(acb_poly_t h, const acb_poly_t f, const acb_poly_t g, long len, long prec)
    void _acb_poly_pow_acb_series(acb_ptr h, acb_srcptr f, long flen, const acb_t g, long len, long prec)
    void acb_poly_pow_acb_series(acb_poly_t h, const acb_poly_t f, const acb_t g, long len, long prec)
    void _acb_poly_sqrt_series(acb_ptr g, acb_srcptr h, long hlen, long n, long prec)
    void acb_poly_sqrt_series(acb_poly_t g, const acb_poly_t h, long n, long prec)
    void _acb_poly_rsqrt_series(acb_ptr g, acb_srcptr h, long hlen, long n, long prec)
    void acb_poly_rsqrt_series(acb_poly_t g, const acb_poly_t h, long n, long prec)
    void _acb_poly_log_series(acb_ptr res, acb_srcptr f, long flen, long n, long prec)
    void acb_poly_log_series(acb_poly_t res, const acb_poly_t f, long n, long prec)
    void _acb_poly_atan_series(acb_ptr res, acb_srcptr f, long flen, long n, long prec)
    void acb_poly_atan_series(acb_poly_t res, const acb_poly_t f, long n, long prec)
    void _acb_poly_exp_series_basecase(acb_ptr f, acb_srcptr h, long hlen, long n, long prec)
    void acb_poly_exp_series_basecase(acb_poly_t f, const acb_poly_t h, long n, long prec)
    void _acb_poly_exp_series(acb_ptr f, acb_srcptr h, long hlen, long n, long prec)
    void acb_poly_exp_series(acb_poly_t f, const acb_poly_t h, long n, long prec)
    void _acb_poly_sin_cos_series_basecase(acb_ptr s, acb_ptr c, acb_srcptr h, long hlen, long n, long prec, int times_pi)
    void acb_poly_sin_cos_series_basecase(acb_poly_t s, acb_poly_t c, const acb_poly_t h, long n, long prec, int times_pi)
    void _acb_poly_sin_cos_series_tangent(acb_ptr s, acb_ptr c, acb_srcptr h, long hlen, long n, long prec, int times_pi)
    void acb_poly_sin_cos_series_tangent(acb_poly_t s, acb_poly_t c, const acb_poly_t h, long n, long prec, int times_pi)
    void _acb_poly_sin_cos_series(acb_ptr s, acb_ptr c, acb_srcptr h, long hlen, long n, long prec)
    void acb_poly_sin_cos_series(acb_poly_t s, acb_poly_t c, const acb_poly_t h, long n, long prec)
    void _acb_poly_sin_series(acb_ptr s, acb_srcptr h, long hlen, long n, long prec)
    void acb_poly_sin_series(acb_poly_t s, const acb_poly_t h, long n, long prec)
    void _acb_poly_cos_series(acb_ptr c, acb_srcptr h, long hlen, long n, long prec)
    void acb_poly_cos_series(acb_poly_t c, const acb_poly_t h, long n, long prec)
    void _acb_poly_tan_series(acb_ptr g, acb_srcptr h, long hlen, long len, long prec)
    void acb_poly_tan_series(acb_poly_t g, const acb_poly_t h, long n, long prec)
    void _acb_poly_sin_cos_pi_series(acb_ptr s, acb_ptr c, acb_srcptr h, long hlen, long n, long prec)
    void acb_poly_sin_cos_pi_series(acb_poly_t s, acb_poly_t c, const acb_poly_t h, long n, long prec)
    void _acb_poly_sin_pi_series(acb_ptr s, acb_srcptr h, long hlen, long n, long prec)
    void acb_poly_sin_pi_series(acb_poly_t s, const acb_poly_t h, long n, long prec)
    void _acb_poly_cos_pi_series(acb_ptr c, acb_srcptr h, long hlen, long n, long prec)
    void acb_poly_cos_pi_series(acb_poly_t c, const acb_poly_t h, long n, long prec)
    void _acb_poly_cot_pi_series(acb_ptr c, acb_srcptr h, long hlen, long n, long prec)
    void acb_poly_cot_pi_series(acb_poly_t c, const acb_poly_t h, long n, long prec)
    void _acb_poly_sinh_cosh_series_basecase(acb_ptr s, acb_ptr c, acb_srcptr h, long hlen, long n, long prec)
    void acb_poly_sinh_cosh_series_basecase(acb_poly_t s, acb_poly_t c, const acb_poly_t h, long n, long prec)
    void _acb_poly_sinh_cosh_series_exponential(acb_ptr s, acb_ptr c, acb_srcptr h, long hlen, long n, long prec)
    void acb_poly_sinh_cosh_series_exponential(acb_poly_t s, acb_poly_t c, const acb_poly_t h, long n, long prec)
    void _acb_poly_sinh_cosh_series(acb_ptr s, acb_ptr c, acb_srcptr h, long hlen, long n, long prec)
    void acb_poly_sinh_cosh_series(acb_poly_t s, acb_poly_t c, const acb_poly_t h, long n, long prec)
    void _acb_poly_sinh_series(acb_ptr s, acb_srcptr h, long hlen, long n, long prec)
    void acb_poly_sinh_series(acb_poly_t s, const acb_poly_t h, long n, long prec)
    void _acb_poly_cosh_series(acb_ptr c, acb_srcptr h, long hlen, long n, long prec)
    void acb_poly_cosh_series(acb_poly_t c, const acb_poly_t h, long n, long prec)
    void _acb_poly_sinc_series(acb_ptr s, acb_srcptr h, long hlen, long n, long prec)
    void acb_poly_sinc_series(acb_poly_t s, const acb_poly_t h, long n, long prec)
    void _acb_poly_gamma_series(acb_ptr res, acb_srcptr h, long hlen, long n, long prec)
    void acb_poly_gamma_series(acb_poly_t res, const acb_poly_t h, long n, long prec)
    void _acb_poly_rgamma_series(acb_ptr res, acb_srcptr h, long hlen, long n, long prec)
    void acb_poly_rgamma_series(acb_poly_t res, const acb_poly_t h, long n, long prec)
    void _acb_poly_lgamma_series(acb_ptr res, acb_srcptr h, long hlen, long n, long prec)
    void acb_poly_lgamma_series(acb_poly_t res, const acb_poly_t h, long n, long prec)
    void _acb_poly_digamma_series(acb_ptr res, acb_srcptr h, long hlen, long n, long prec)
    void acb_poly_digamma_series(acb_poly_t res, const acb_poly_t h, long n, long prec)
    void _acb_poly_rising_ui_series(acb_ptr res, acb_srcptr f, long flen, unsigned long r, long trunc, long prec)
    void acb_poly_rising_ui_series(acb_poly_t res, const acb_poly_t f, unsigned long r, long trunc, long prec)
    void _acb_poly_powsum_series_naive(acb_ptr z, const acb_t s, const acb_t a, const acb_t q, long n, long len, long prec)
    void _acb_poly_powsum_series_naive_threaded(acb_ptr z, const acb_t s, const acb_t a, const acb_t q, long n, long len, long prec)
    void _acb_poly_powsum_one_series_sieved(acb_ptr z, const acb_t s, long n, long len, long prec)
    void _acb_poly_zeta_em_choose_param(mag_t bound, unsigned long * N, unsigned long * M, const acb_t s, const acb_t a, long d, long target, long prec)
    void _acb_poly_zeta_em_bound1(mag_t bound, const acb_t s, const acb_t a, long N, long M, long d, long wp)
    # void _acb_poly_zeta_em_bound(arb_ptr vec, const acb_t s, const acb_t a, unsigned long N, unsigned long M, long d, long wp)
    void _acb_poly_zeta_em_tail_naive(acb_ptr z, const acb_t s, const acb_t Na, acb_srcptr Nasx, long M, long len, long prec)
    void _acb_poly_zeta_em_tail_bsplit(acb_ptr z, const acb_t s, const acb_t Na, acb_srcptr Nasx, long M, long len, long prec)
    void _acb_poly_zeta_em_sum(acb_ptr z, const acb_t s, const acb_t a, int deflate, unsigned long N, unsigned long M, long d, long prec)
    void _acb_poly_zeta_cpx_series(acb_ptr z, const acb_t s, const acb_t a, int deflate, long d, long prec)
    void _acb_poly_zeta_series(acb_ptr res, acb_srcptr h, long hlen, const acb_t a, int deflate, long len, long prec)
    void acb_poly_zeta_series(acb_poly_t res, const acb_poly_t f, const acb_t a, int deflate, long n, long prec)
    void _acb_poly_polylog_cpx_small(acb_ptr w, const acb_t s, const acb_t z, long len, long prec)
    void _acb_poly_polylog_cpx_zeta(acb_ptr w, const acb_t s, const acb_t z, long len, long prec)
    void _acb_poly_polylog_cpx(acb_ptr w, const acb_t s, const acb_t z, long len, long prec)
    void _acb_poly_polylog_series(acb_ptr w, acb_srcptr s, long slen, const acb_t z, long len, long prec)
    void acb_poly_polylog_series(acb_poly_t w, const acb_poly_t s, const acb_t z, long len, long prec)
    void _acb_poly_erf_series(acb_ptr res, acb_srcptr z, long zlen, long n, long prec)
    void acb_poly_erf_series(acb_poly_t res, const acb_poly_t z, long n, long prec)
    void _acb_poly_agm1_series(acb_ptr res, acb_srcptr z, long zlen, long len, long prec)
    void acb_poly_agm1_series(acb_poly_t res, const acb_poly_t z, long n, long prec)
    void _acb_poly_elliptic_k_series(acb_ptr res, acb_srcptr z, long zlen, long len, long prec)
    void acb_poly_elliptic_k_series(acb_poly_t res, const acb_poly_t z, long n, long prec)
    void _acb_poly_elliptic_p_series(acb_ptr res, acb_srcptr z, long zlen, const acb_t tau, long len, long prec)
    void acb_poly_elliptic_p_series(acb_poly_t res, const acb_poly_t z, const acb_t tau, long n, long prec)
    void _acb_poly_root_bound_fujiwara(mag_t bound, acb_srcptr poly, long len)
    void acb_poly_root_bound_fujiwara(mag_t bound, acb_poly_t poly)
    void _acb_poly_root_inclusion(acb_t r, const acb_t m, acb_srcptr poly, acb_srcptr polyder, long len, long prec)
    long _acb_poly_validate_roots(acb_ptr roots, acb_srcptr poly, long len, long prec)
    void _acb_poly_refine_roots_durand_kerner(acb_ptr roots, acb_srcptr poly, long len, long prec)
    long _acb_poly_find_roots(acb_ptr roots, acb_srcptr poly, acb_srcptr initial, long len, long maxiter, long prec)
    long acb_poly_find_roots(acb_ptr roots, const acb_poly_t poly, acb_srcptr initial, long maxiter, long prec)
    bint _acb_poly_validate_real_roots(acb_srcptr roots, acb_srcptr poly, long len, long prec)
    bint acb_poly_validate_real_roots(acb_srcptr roots, const acb_poly_t poly, long prec)
