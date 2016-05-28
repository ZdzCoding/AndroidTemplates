package ${packageName}.interactor;

import com.android.volley.JsonAuthRequest;
import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.error.VolleyError;
import com.google.gson.reflect.TypeToken;
import com.zdz.baseproject.R;
import com.zdz.jok.constant.EventAction;
import com.zdz.jok.interfaces.BaseInteractor;
import com.zdz.jok.interfaces.BaseLoadListener;
import com.zdz.jok.interfaces.ErrorCode;
import com.zdz.jok.runtime.RT;
import com.zdz.jok.ui.model.${itemClass};
import com.zdz.jok.util.ITypeDef;
import com.zdz.jok.util.JSONParser;
import com.zdz.jok.util.Network;
import com.zdz.jok.util.ToastUtil;
import com.zdz.jok.util.VolleyHelper;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by zhaodaizheng on 16/4/21.
 */
public class ${itemClass}InteractorImpl implements BaseInteractor{

    private BaseLoadListener<${itemClass}> loadListener;
    public ${itemClass}InteractorImpl(BaseLoadListener<${itemClass}> listener){
        loadListener = listener;
    }
    @Override
    public void getListData(String url, String tag, final EventAction eventAction) {
        JsonAuthRequest jsonObjectRequest = new JsonAuthRequest(Request.Method.GET, url, null, new Response.Listener<JSONObject>() {
            @Override
            public void onResponse(JSONObject response) {
                if (response != null) {

                    String showapi_res_error = response.optString("errorCode");
                    if (showapi_res_error.equals("0")) {
                        JSONObject content = response.optJSONObject("data");
                        int totalpage = content.optInt("total");
                        JSONArray ja = content.optJSONArray("data");
                        if (ja != null&&ja.length()>0) {
                            loadListener.onSuccess((ArrayList<${itemClass}>) JSONParser.toObject(ja.toString(), new TypeToken<ArrayList<${itemClass}>>() {
                            }.getType()),eventAction);
                        }else{
                            loadListener.onError(eventAction, ErrorCode.EmptyErrorByNet);
                        }
                    }
                }
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                if(Network.netWorkState(RT.application)== ITypeDef.DM_NETWORK_TYPE_NONE )
                {
                    ToastUtil.showtoast(RT.getString(R.string.net_error_tip));
                    loadListener.onError(eventAction,ErrorCode.NetError);
                }else{
                    loadListener.onError(eventAction,ErrorCode.ServerError);
                }
            }
        });
        jsonObjectRequest.setHeaders("apikey", "574ee1df27283b13effed1679a418a47");
        jsonObjectRequest.setShouldCache(false);
        VolleyHelper.getInstance().getRequestQueue().add(jsonObjectRequest);
    }

    @Override
    public void loadCache() {
        loadListener.onError(EventAction.EVENT_LOAD_CACHE_DATA,ErrorCode.EmptyErrorByCache);
        /*
        ${itemClass}CacheManage videoCacheUtil = ${itemClass}CacheManage.getInstance(RT.application);
        List<${itemClass}> list=videoCacheUtil.getCacheByPage(1);
        if(list.size()>0){
            loadListener.onSuccess(list,EventAction.EVENT_LOAD_CACHE_DATA);
        }else{
            loadListener.onError(EventAction.EVENT_LOAD_CACHE_DATA,ErrorCode.EmptyErrorByCache);
        }
        */
    }
}