package ${packageName}.adapter;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.zdz.baseproject.R;
import com.zdz.jok.ui.model.TextJoke;

import java.util.List;

import butterknife.ButterKnife;

/**
 * A custom array adapter. ${layoutName}
 */
public class ${itemClass}Adapter extends BaseAdapter<${itemClass},${itemClass}Adapter.${itemClass}AdapterViewHolder> {

    public ${itemClass}Adapter(Context context, List<${itemClass}> data) {
        super(context, R.layout.${layoutName}, data);
    }

    public ${itemClass}Adapter(Context context, View contentView, List<${itemClass}> data) {
        super(context, contentView, data);
    }

    @Override
    public ${itemClass}AdapterViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View v = LayoutInflater.from(parent.getContext()).inflate(R.layout.${layoutName}, parent, false);
        return new ${itemClass}AdapterViewHolder(v);
    }

    @Override
    protected void convert(${itemClass}AdapterViewHolder helper, ${itemClass} beauty) {
        
    }

    public static class ${itemClass}AdapterViewHolder extends RecyclerView.ViewHolder {

        public ${itemClass}AdapterViewHolder(View contentView) {
            super(contentView);
            ButterKnife.bind(this, contentView);
        }
    }

}
