template<class T> struct Splay
{
	struct Node
	{
		int s[2],p; //存储子节点和父节点
		int v; //节点的编号
		int size; //子树的大小
		bool flag; //懒标记

		void init(int _v,int _p)
		{
			v = _v,p = _p;
			size = 1;
		}
	} tr[N];
	int root,idx; // 根节点和节点下标
	int size; // 序列的大小

	void pushup(int u)
	{
		tr[u].size = tr[tr[u].s[0]].size + tr[tr[u].s[1]].size + 1;
	}

	void pushdown(int u)
	{
		if(tr[u].flag)
		{
			// 执行操作
			swap(tr[u].s[0],tr[u].s[1]);
			// 对懒标记的操作
			tr[tr[u].s[0]].flag ^= 1;
			tr[tr[u].s[1]].flag ^= 1;
			tr[u].flag = 0;
		}
	}

	void rotate(int x) // 旋转操作，两种旋转在一个函数中完成
	{
		int y = tr[x].p,z = tr[y].p;// 找出当前节点x的父节点y和y的父节点z
		int k = tr[y].s[1] == x; // k=1时，x为y的右儿子，k=0时，x为y的左儿子
		tr[z].s[tr[z].s[1] == y] = x,tr[x].p = z;
		tr[y].s[k] = tr[x].s[k ^ 1],tr[tr[x].s[k ^ 1]].p = y;
		tr[x].s[k ^ 1] = y,tr[y].p = x;
		pushup(y),pushup(x);
	}

	void splay(int x,int k) // 将x转到k的下面，当k为0时，即将x转到根节点
	{
		while(tr[x].p != k)
		{
			int y = tr[x].p,z = tr[y].p;
			if(z != k)
				if((tr[y].s[1] == x) ^ (tr[z].s[1] == y)) // xyz呈折线关系，转两次x
					rotate(x);
				else rotate(y); // xyz呈直线关系，先转y在转x
			rotate(x);
		}
		if(!k) // k为0时，x转到根节点，则更新根节点
			root = x;
	}

	void insert(int v)
	{
		int u = root,p = 0;
		while(u)
			p = u,u = tr[u].s[v > tr[u].v]; // 更新父节点，判断往左走还是往右走
		u = ++idx; // 给插入的点分配下标
		if(p) // 更新父节点的子节点
			tr[p].s[v > tr[p].v] = u;
		tr[u].init(v,p); // 初始化新建点的信息
		splay(u, 0); // 将当前点旋转到根节点
	}

	int get_k(int k) // 寻找中序遍历中的第k个数
	{
		int u = root;
		while(true)
		{
			pushdown(u);
			if(tr[tr[u].s[0]].size >= k) // 在左子树
				u = tr[u].s[0];
			else if(tr[tr[u].s[0]].size + 1 == k) // 是当前节点
				return u;
			else // 在右子树
				k -= tr[tr[u].s[0]].size + 1,u = tr[u].s[1];
		}
		return -1;
	}

	void output(int u) // 输出该splay
	{
		pushdown(u); // 先pushdown
		if(tr[u].s[0]) // 如果存在左儿子就往左递归
			output(tr[u].s[0]);
		if(tr[u].v >= 1 && tr[u].v <= size) // 如果当前节点不是哨兵，就直接输出
			cout << tr[u].v << ' ';
		if(tr[u].s[1]) // 如果存在右儿子就往右递归
			output(tr[u].s[1]);
	}

	void init(int n)
	{
		size = n;
		for(int i = 0;i <= size + 1;++i) // 插入0和size + 1两个哨兵
			insert(i);
	}

    // 具体的操作，根据实际情况改写
	void op(int l,int r) 
	{
		l = get_k(l),r = get_k(r + 2);
		splay(l, 0),splay(r, l);
		tr[tr[r].s[0]].flag ^= 1;
	}
};
