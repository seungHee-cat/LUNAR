package project.kr.com.util;

import lombok.Data;
import org.json.JSONObject;

import java.util.ArrayList;

@Data
@SuppressWarnings("rawtypes")
public class Response {
	private boolean	isOk;
	private String	message;
	private Object data;

	public Response()
	{
		this(true, "");
	}

    public Response(boolean isOk)
	{
		this(isOk, "");
	}

	public Response(String message)
	{
		this(true, message);
	}

	public Response(boolean isOk, String message)
	{
		this(isOk, message, null);
	}

	public Response(boolean isOk, String message, ArrayList response)
	{
		this.isOk = isOk;
		this.message = message;
		if (response != null)
			this.data = response;
		else
			this.data = new ArrayList();
	}

    public Response(boolean isOk, Object response)
	{
		this.isOk = isOk;
		this.message = "";
		if (response != null)
			this.data = response;
		else
			this.data = new ArrayList();
	}

	public String convertJSONString() {
		JSONObject obj = new JSONObject();
		obj.put("ok", this.isOk);
		obj.put("message", this.message);
		return obj.toString();
	}

	@Override
	public String toString() {
		return this.convertJSONString();
	}
}