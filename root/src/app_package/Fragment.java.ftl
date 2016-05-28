package ${packageName}.fragment;



import butterknife.Bind;
import butterknife.ButterKnife;

/**
 * Created by zhaodaizheng on 16/4/21.
 */
public class ${itemClass}Fragment extends BaseLazyFragment implements XRecyclerView.LoadingListener, ${itemClass}Contract.View{

    @Bind(R.id.${fragment_layoutName}_list)
    XRecyclerView mRecyclerView;

    private ${itemClass}Contract.Presenter mPresenter;
    private ${itemClass}Adapter mAdapter = null;
    private int page = 1;
    public static final int PAGE_SIZE = 20;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.${fragment_layoutName}, container, false);
        ButterKnife.bind(this, view);
        return view;

    }

    @Override
    protected void lazyLoad() {

    }

    @Override
    protected void init() {
        mPresenter = new ${itemClass}Presenter(this);
        LinearLayoutManager layoutManager = new LinearLayoutManager(getActivity());
        layoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        mRecyclerView.setLayoutManager(layoutManager);

        mRecyclerView.setRefreshProgressStyle(ProgressStyle.BallSpinFadeLoader);
        mRecyclerView.setLoadingMoreProgressStyle(ProgressStyle.BallRotate);
        mRecyclerView.setArrowImageView(R.drawable.ic_pulltorefresh_arrow);

        mRecyclerView.setLoadingListener(this);
        mAdapter = new ${itemClass}Adapter(getActivity(),new ArrayList<${itemClass}>());

        mRecyclerView.setAdapter(mAdapter);
//        mRecyclerView.setRefreshing(true);
        mRecyclerView.setPullRefreshEnabled(true);

        mPresenter.loadCache();
    }

    @Override
    protected View getLoadingTargetView() {
        return mRecyclerView;
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        ButterKnife.unbind(this);
    }

    public void onLoadData() {
        page = 1;
        mPresenter.refersh("http://192.168.0.16:8085/beauty/page?page="+page, TAG_LOG, EventAction.EVENT_BEGIN);
    }

    @Override
    public void onRefresh() {
        page = 1;
        mPresenter.refersh("http://192.168.0.16:8085/beauty/page?page="+page, TAG_LOG, EventAction.EVENT_REFRESH_DATA);
    }

    @Override
    public void onLoadMore() {
        page++;
        mPresenter.loadMore("http://192.168.0.16:8085/beauty/page?page="+page, TAG_LOG, EventAction.EVENT_LOAD_MORE_DATA);
    }

    @Override
    public void refersh(List<${itemClass}> list) {

    }

    @Override
    public void loadMore(List<${itemClass}> list) {
       
    }

    @Override
    public void setPresenter(${itemClass}Contract.Presenter presenter) {
        
    }

    @Override
    public void showEmpty() {

    }

    @Override
    public void showError() {
        
    }

    @Override
    public void showLoading() {
        toggleShowLoading(true, "加载中...");
    }

    @Override
    public void hideLoading() {
        toggleShowLoading(false, null);
    }

    @Override
    public void hideRefreshing() {
        mRecyclerView.refreshComplete();
    }

    @Override
    public void showToastError(String msg) {
        ToastUtil.showtoast(msg);
    }

    @Override
    public boolean isDataEmpty(){
        if (mAdapter.getDataList()!=null&&mAdapter.getDataList().size()>0){
            return false;
        }
        return true;
    }

    @Override
    public void unCache() {
        showLoading();
        onLoadData();
    }

    @Override
    public void alreadyCache() {
        mRecyclerView.setRefreshing(true);
    }
}
