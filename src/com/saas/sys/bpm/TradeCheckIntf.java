package com.saas.sys.bpm;

import com.saas.sys.buffer.Buffers;
import java.util.ArrayList;

public abstract interface TradeCheckIntf
{
  public abstract ArrayList ExecTradeCheck(Buffers paramBuffers);

  public abstract Buffers getOutBuffer();
}

/* Location:           D:\project\代码\b2b-new-20090709\b2bv2-Pure-Simplify\WEB-INF\classes\
 * Qualified Name:     com.saas.sys.bpm.TradeCheckIntf
 * JD-Core Version:    0.6.0
 */