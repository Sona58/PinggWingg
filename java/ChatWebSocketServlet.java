public class ChatWebSocketServlet extends webSocketServlet{
	protected StreamInbound createWebSocketInbound(String subProtocol){
		return new ChatMessageInbound();
	}
	protected void onBinaryData(InputStream is);
	protected void onTextData(Reader r);
	@Override
	protected void onOpen(WsOutbound outbound);
 
	@Override
	protected void onClose(int status);
}

private final class ChatMessageInbound extends MessageInbound {
 
	@Override
	protected void onBinaryMessage(ByteBuffer message) throws IOException {
		throw new UnsupportedOperationException(
		"Binary message not supported.");
	}
	 
	@Override
	protected void onTextMessage(CharBuffer message) throws IOException {
		String msg = message.toString();
		msg = “(“ + System.currentTimeMillis()+”) “+ msg;
		broadcast(msg);
	}
	 
	private void broadcast(String message) {
	
	}
}