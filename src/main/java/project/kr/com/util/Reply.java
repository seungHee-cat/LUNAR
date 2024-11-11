package project.kr.com.util;

import lombok.Data;
import org.json.simple.JSONObject;

import java.util.ArrayList;
import java.util.Map;

@Data
@SuppressWarnings("rawtypes")
public class Reply {
	final static String REPLY_NAME = Reply.class.getName();
	private boolean	isOk;
	private String	message;
	private Object data;
	private Map<String, Object>	detailData;

	public Reply()
	{
		this(true, "");
	}

    public Reply(boolean isOk)
	{
		this(isOk, "");
	}

	public Reply(String message)
	{
		this(true, message);
	}

	public Reply(boolean isOk, String message)
	{
		this(isOk, message, null);
	}

	public Reply(boolean isOk, String message, ArrayList reply)
	{
		this.isOk = isOk;
		this.message = message;
		if (reply != null)
			this.data = reply;
		else
			this.data = new ArrayList();
	}

    public Reply(boolean isOk, Object reply)
	{
		this.isOk = isOk;
		this.message = "";
		if (reply != null)
			this.data = reply;
		else
			this.data = new ArrayList();
	}

	public String toJSONString() {
		JSONObject jObj = new JSONObject();
		jObj.put("ok", this.isOk);
		jObj.put("message", this.message);
		return jObj.toString();
	}

	@Override
	public String toString() {
		return this.toJSONString();
	}
}