package com.saas.biz.dao.staffDAO;

import com.saas.sys.dbm.Dbexecute;
import com.saas.sys.log.Logger;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import org.apache.commons.beanutils.PropertyUtils;

public class SatffExt extends StaffDAO
{
  StaffDAO staffDao = new StaffDAO();
  Logger log = new Logger(this);
  ArrayList updArray = new ArrayList();
  ArrayList paramArray = new ArrayList();

  public ArrayList selByList(String paramString)
  {
    Dbexecute localDbexecute = new Dbexecute();
    ArrayList localArrayList = new ArrayList();
    localDbexecute.setStrTable("staffinfo");
    localDbexecute.setStrQuery(paramString);
    localDbexecute.setParamList(this.paramArray);
    localArrayList = localDbexecute.selBizQuery();
    if (localArrayList.size() <= 0)
      return null;
    return localArrayList;
  }

  public StaffDAO selByInfo(String paramString)
  {
    Dbexecute localDbexecute = new Dbexecute();
    StaffDAO localStaffDAO = new StaffDAO();
    ArrayList localArrayList = new ArrayList();
    localDbexecute.setStrTable("staffinfo");
    localDbexecute.setStrQuery(paramString);
    localDbexecute.setParamList(this.paramArray);
    localArrayList = localDbexecute.selBizQuery();
    if (localArrayList.size() <= 0)
      return null;
    Field[] arrayOfField = localStaffDAO.getClass().getDeclaredFields();
    Iterator localIterator = localArrayList.iterator();
    while (localIterator.hasNext())
    {
      HashMap localHashMap = (HashMap)localIterator.next();
      for (int i = 0; i <= arrayOfField.length - 1; i++)
      {
        if (!localHashMap.containsKey(arrayOfField[i].getName()))
          continue;
        try
        {
          if (localHashMap.get(arrayOfField[i].getName()) != null)
            if (arrayOfField[i].getType().getName() == "java.lang.String")
            {
              PropertyUtils.setProperty(localStaffDAO, arrayOfField[i].getName(), localHashMap.get(arrayOfField[i].getName()).toString());
            }
            else if (arrayOfField[i].getType().getName() == "java.lang.Integer")
            {
              Integer localInteger = new Integer(localHashMap.get(arrayOfField[i].getName()).toString());
              PropertyUtils.setProperty(localStaffDAO, arrayOfField[i].getName(), localInteger);
            }
        }
        catch (InvocationTargetException localInvocationTargetException)
        {
          throw new RuntimeException(localInvocationTargetException);
        }
        catch (NoSuchMethodException localNoSuchMethodException)
        {
          throw new RuntimeException(localNoSuchMethodException);
        }
        catch (IllegalAccessException localIllegalAccessException)
        {
          throw new RuntimeException(localIllegalAccessException);
        }
      }
    }
    return localStaffDAO;
  }

  public int selCount(String paramString)
  {
    return 0;
  }

  public void setParam(String paramString, Object paramObject)
  {
    HashMap localHashMap = new HashMap();
    localHashMap.put("paramName", paramString);
    localHashMap.put("paramValue", paramObject);
    this.paramArray.add(localHashMap);
  }
}

/* Location:           D:\project\代码\b2b-new-20090709\b2bv2-Pure-Simplify\WEB-INF\classes\
 * Qualified Name:     com.saas.biz.dao.staffDAO.SatffExt
 * JD-Core Version:    0.6.0
 */