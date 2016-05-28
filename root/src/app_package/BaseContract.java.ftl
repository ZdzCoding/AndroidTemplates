package ${packageName}.presenter;

import com.zdz.jok.constant.EventAction;
import com.zdz.jok.interfaces.BasePresenter;
import com.zdz.jok.interfaces.BaseView;
import com.zdz.jok.ui.model.${itemClass};

import java.util.List;

/**
 * Created by zhaodaizheng on 16/4/28.
 */
public class ${itemClass}Contract {

    public interface View extends BaseView<Presenter> {
        void refersh(List<${itemClass}> list);
        void loadMore(List<${itemClass}> list);
        boolean isDataEmpty();
        void unCache();
        void alreadyCache();
    }

    public interface Presenter extends BasePresenter {
        void refersh(String url, String tag, EventAction action);
        void loadMore(String url, String tag, EventAction action);
        void loadCache();
    }
}
