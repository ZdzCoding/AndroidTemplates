package ${packageName}.presenter;

import android.support.annotation.Nullable;

import com.zdz.jok.constant.EventAction;
import com.zdz.jok.interfaces.BaseInteractor;
import com.zdz.jok.interfaces.BaseLoadListener;
import com.zdz.jok.interfaces.ErrorCode;
import com.zdz.jok.ui.interactor.TextJokeInteractorImpl;
import com.zdz.jok.ui.model.TextJoke;
import com.zdz.jok.util.ToastUtil;

import java.util.List;
/**
 * Created by zhaodaizheng on 16/4/28.
 */
public class ${itemClass}Presenter implements ${itemClass}Contract.Presenter , BaseLoadListener<${itemClass}> {

    private ${itemClass}Contract.View m${itemClass}View;
    private BaseInteractor m${itemClass}Interactor;

    public ${itemClass}Presenter(@Nullable ${itemClass}Contract.View mView){
        this.m${itemClass}View = mView;
        m${itemClass}View.setPresenter(this);
        m${itemClass}Interactor = new ${itemClass}InteractorImpl(this);
    }


    @Override
    public void refersh(String url, String tag, EventAction action) {
        m${itemClass}Interactor.getListData(url,tag,action);
    }

    @Override
    public void loadMore(String url, String tag, EventAction action) {
        m${itemClass}Interactor.getListData(url,tag,action);
    }

    @Override
    public void loadCache() {
        m${itemClass}Interactor.loadCache();
    }

    @Override
    public void init(String url,String tag) {
        m${itemClass}View.showLoading();
        m${itemClass}Interactor.getListData(url,tag,EventAction.EVENT_BEGIN);
    }

    @Override
    public void onSuccess(List<${itemClass}> data,EventAction eventAction) {
        if (eventAction==EventAction.EVENT_REFRESH_DATA){
            m${itemClass}View.hideRefreshing();
            m${itemClass}View.refersh(data);
        }else if (eventAction==EventAction.EVENT_LOAD_MORE_DATA){
            m${itemClass}View.loadMore(data);
        }else if (eventAction==EventAction.EVENT_BEGIN){
            m${itemClass}View.hideLoading();
            m${itemClass}View.refersh(data);
        }else if(eventAction==EventAction.EVENT_LOAD_CACHE_DATA){
            m${itemClass}View.alreadyCache();
            m${itemClass}View.refersh(data);
        }
    }

    @Override
    public void onError(EventAction action,int code) {
        if(action==EventAction.EVENT_BEGIN){
            m${itemClass}View.hideLoading();
        }else if (action==EventAction.EVENT_REFRESH_DATA){
            m${itemClass}View.hideRefreshing();
        }
        switch (code){
            case ErrorCode.EmptyErrorByNet:
                m${itemClass}View.showEmpty();
                break;
            case ErrorCode.NetError:
                if (m${itemClass}View.isDataEmpty()){
                    m${itemClass}View.showError();
                }
                ToastUtil.showtoast("网络错误");
                break;
            case ErrorCode.ServerError:
                ToastUtil.showtoast("服务器问题");
                break;
            case ErrorCode.EmptyErrorByCache:
                ToastUtil.showtoast("没有缓存");
                m${itemClass}View.unCache();
                break;
        }
    }

    @Override
    public void onException(String msg) {
        m${itemClass}View.hideLoading();
        m${itemClass}View.showError();
    }
}