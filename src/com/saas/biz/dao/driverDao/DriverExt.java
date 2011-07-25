package com.saas.biz.dao.driverDao;

import com.saas.biz.commen.commMethodMgr;
import com.saas.sys.dbm.Dbexecute;
import com.saas.sys.log.Logger;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import org.apache.commons.beanutils.PropertyUtils;

public class DriverExt extends DriverDao
{
  DriverDao driverDao = new DriverDao();
  Logger log = new Logger(this);
  ArrayList updArray = new ArrayList();
  ArrayList paramArray = new ArrayList();

  public ArrayList selByList(String paramString)
  {
    Dbexecute localDbexecute = new Dbexecute();
    ArrayList localArrayList = new ArrayList();
    localDbexecute.setStrTable("tf_f_driverinfo");
    localDbexecute.setStrQuery(paramString);
    localDbexecute.setParamList(this.paramArray);
    localArrayList = localDbexecute.selBizQuery();
    if (localArrayList.size() <= 0)
      return null;
    return localArrayList;
  }

  public ArrayList selByList(String paramString, int paramInt1, int paramInt2)
  {
    Dbexecute localDbexecute = new Dbexecute();
    ArrayList localArrayList = new ArrayList();
    localDbexecute.setStrTable("tf_f_driverinfo");
    localDbexecute.setStrQuery(paramString);
    localDbexecute.setParamList(this.paramArray);
    localArrayList = localDbexecute.selBizQuery(paramInt1, paramInt2);
    if (localArrayList.size() <= 0)
      return null;
    return localArrayList;
  }

  public DriverDao selByInfo(String paramString)
  {
    Dbexecute localDbexecute = new Dbexecute();
    commMethodMgr localcommMethodMgr = new commMethodMgr();
    Logger localLogger = new Logger(this);
    ArrayList localArrayList = new ArrayList();
    localDbexecute.setStrTable("tf_f_driverinfo");
    localDbexecute.setStrQuery(paramString);
    localDbexecute.setParamList(this.paramArray);
    localArrayList = localDbexecute.selBizQuery();
    if (localArrayList.size() <= 0)
      return null;
    DriverDao localDriverDao = new DriverDao();
    Field[] arrayOfField = localDriverDao.getClass().getDeclaredFields();
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
              PropertyUtils.setProperty(localDriverDao, arrayOfField[i].getName(), localHashMap.get(arrayOfField[i].getName()).toString());
            }
            else if (arrayOfField[i].getType().getName() == "java.lang.Integer")
            {
              Integer localInteger = new Integer(localHashMap.get(arrayOfField[i].getName()).toString());
              PropertyUtils.setProperty(localDriverDao, arrayOfField[i].getName(), localInteger);
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
    return localDriverDao;
  }

  public int selCount(String paramString)
  {
    Dbexecute localDbexecute = new Dbexecute();
    return 0;
  }

  public void setParam(String paramString, Object paramObject)
  {
    HashMap localHashMap = new HashMap();
    localHashMap.put("paramName", paramString);
    localHashMap.put("paramValue", paramObject);
    this.paramArray.add(localHashMap);
  }

  public ArrayList insBy(String paramString)
  {
    ArrayList localArrayList = new ArrayList();
    HashMap localHashMap = new HashMap();
    localHashMap.put("queryTable", "tf_f_driverinfo");
    localHashMap.put("queryString", paramString);
    localHashMap.put("queryVarMap", this.paramArray);
    localArrayList.add(localHashMap);
    this.log.LOG_INFO("Sql=" + localArrayList);
    return localArrayList;
  }
}

/* Location:           D:\project\代码\b2b-new-20090709\b2bv2-Pure-Simplify\WEB-INF\classes\
 * Qualified Name:     com.saas.biz.dao.driverDao.DriverExt
 * JD-Core Version:    0.6.0
 */