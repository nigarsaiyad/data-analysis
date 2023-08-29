#!/usr/bin/env python
# coding: utf-8

# In[16]:


import pandas as pd


# In[17]:


df= pd.read_excel(r"C:\Users\PC\Downloads\Customers call list.xlsx")
df


# # duplicates handling

# In[18]:


df=df.drop_duplicates()
df


# # dropping irrelevant columns 

# In[19]:


df=df.drop ( columns="Registered_Age" )
df


# In[20]:


import warnings
warnings.filterwarnings("ignore")


# ## standardizing phone numbers 
# 

# In[21]:


#df["phone no"].str.replace('[^a-zA-Z0-9]',' ')
df["phone no"]=df["phone no"].apply(lambda x:str(x))
#df["phone no"].apply(lambda x :x[0:3]+'-' + x[3:6] + '-'+ x[6:10])
df["phone no"].str.replace('[ABB-Bas-sas]',' ')
df["phone no"]=df["phone no"].apply(lambda x :x[0:3]+'-' + x[3:6] + '-'+ x[6:10])
df


# In[22]:


df["phone no"]=df["phone no"].str.replace('[ABB-Bas-sas]',' ')
df


# In[10]:


df


# # handling null values
# 

# In[11]:


df=df.fillna('')


# In[12]:


for x in df.index:
    if df.loc[x,"do not contact"] == 'yes':
        df.drop(x,inplace= True)
df


# In[13]:


for x in df.index:
    if df.loc[x,"phone no"] == '-':
        df.drop(x,inplace= True)
df


# In[14]:


df=df.reset_index(drop=True)
df


# # EDA USING PANDAS

# In[27]:


import pandas as pd  
import seaborn as sns
import matplotlib.pyplot as plt


# In[28]:


df= pd.read_csv(r"C:\Users\PC\Downloads\world_population.csv")
df


# In[29]:


pd.set_option('display.float_format',lambda x : '%.2f'%x)


# In[30]:


df.info()


# In[31]:


df.describe()


# In[32]:


df.isnull().sum()


# In[33]:


df.nunique()


# In[34]:


df.sort_values(by="2022 Population" , ascending = False).head(10)


# In[ ]:


import warnings
warnings.filterwarnings("ignore")


# In[35]:


df.corr()


# In[36]:


sns.heatmap(df.corr(),annot=True)
plt.rcParams['figure.figsize']=(25,7)
plt.show()


# In[37]:


df.groupby('Continent').mean()


# In[38]:


df.groupby('Continent').mean().sort_values(by="2022 Population",ascending=False)


# In[39]:


df[df['Continent'].str.contains('Oceania')]


# In[40]:


df2=df.groupby('Continent').mean().sort_values(by="2022 Population",ascending=False)
df2


# In[41]:


df.columns


# In[49]:


df2=df.groupby('Continent')[[ '1970 Population', '1980 Population',
       '1990 Population', '2000 Population', '2010 Population',
       '2015 Population', '2020 Population','2022 Population']].mean().sort_values(by="2022 Population",ascending=False)
df2


# In[50]:


df3=df2.transpose()
df3


# In[51]:


df3.plot()


# # finding outliers

# In[52]:


df.boxplot()


# In[53]:


df.dtypes

