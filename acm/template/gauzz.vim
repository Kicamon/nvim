template <class T = int> struct Gauzz
{
    const double eps = 1e-6;
    double a[N][N];
    int size;
    void resize(int n)
    {
        size = n;
    }
    T gauzz()
    {
        int c, r;
        for (c = 0, r = 0; c < size; c++)
        {
            int t = r;
            for (int i = r; i < size; i++)
                if (fabs(a[i][c]) > fabs(a[t][c]))
                    t = i;
            if (fabs(a[t][c]) < eps)
                continue;

            for (int i = c; i <= size; i++)
                swap(a[t][i], a[r][i]);
            for (int i = size; i >= c; --i)
                a[r][i] /= a[r][c];
            for (int i = r + 1; i < size; i++)
                if (fabs(a[i][c]) > eps)
                    for (int j = size; j >= c; --j)
                        a[i][j] -= a[r][j] * a[i][c];
            r++;
        }
        if (r < size)
        {
            for (int i = r; i < size; i++)
                if (fabs(a[i][size]) > eps)
                    return 2;
            return 1;
        }

        for (int i = size - 1; ~i; --i)
            for (int j = i + 1; j < size; j++)
                a[i][size] -= a[i][j] * a[j][size];

        return 0;
    }

    void get_answer()
    {
        T t = gauzz();
        if (!t)
        {
            for (int i = 0; i < size; ++i)
                if (fabs(a[i][size]) < eps)
                    printf("0.00\n");
                else
                    printf("%.2f\n", a[i][size]);
        }
        else if (t == 1)
            printf("Infinite group solutions\n");
        else
            printf("No solution\n");
    }
};
