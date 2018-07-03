
#define S_FUNCTION_NAME  fsim
#define S_FUNCTION_LEVEL 2

#define MDL_START

#define A(I,J)  (*(mxGetPr(ssGetSFcnParam(S,0))+(mxGetM(ssGetSFcnParam(S,0)))*(J)+(I)))
#define B(I,J)  (*(mxGetPr(ssGetSFcnParam(S,1))+(mxGetM(ssGetSFcnParam(S,1)))*(J)+(I)))
#define C(I,J)  (*(mxGetPr(ssGetSFcnParam(S,2))+(mxGetM(ssGetSFcnParam(S,2)))*(J)+(I)))
#define N(I,J)  (*(mxGetPr(ssGetSFcnParam(S,3))+(mxGetM(ssGetSFcnParam(S,3)))*(J)+(I)))

#define Nx (mxGetM(ssGetSFcnParam(S,0)))
#define Nu (mxGetN(ssGetSFcnParam(S,1)))
#define Ny (mxGetM(ssGetSFcnParam(S,2)))
#define Nbuf ((int)(*(mxGetPr(ssGetSFcnParam(S,5)))))
#define Ts (*(mxGetPr(ssGetSFcnParam(S,4))))
#define X0(I)  (*(mxGetPr(ssGetSFcnParam(S,6))+(I))) 
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include "simstruc.h"



static void mdlInitializeSizes(SimStruct *S)
{

ssSetNumSFcnParams(S, 7);
    if (ssGetNumSFcnParams(S) != ssGetSFcnParamsCount(S)) {
        return; /* Parameter mismatch will be reported by Simulink */
    }

   
    
    if (mxGetM(ssGetSFcnParam(S,0))!=mxGetN(ssGetSFcnParam(S,0))){
    printf("Matrix A must be square\n");
    return;
    }
    
    if (mxGetM(ssGetSFcnParam(S,1))!=mxGetM(ssGetSFcnParam(S,0))){
    printf("matrix B must have the same noumber of rows than matrix A\n");
    return;
    }
    
    if (mxGetN(ssGetSFcnParam(S,2))!=mxGetM(ssGetSFcnParam(S,0))){
    printf("matrix C must have the same noumber of rows than matrix A\n");
    return;
    }
    
    if (mxGetM(ssGetSFcnParam(S,3))!=mxGetM(ssGetSFcnParam(S,0))){
    printf("matrix N must have the same noumber of rows than matrix A\n");
    return;
    }

    
    if (!ssSetNumInputPorts(S, 1)) return;
    ssSetInputPortWidth(S, 0, Nu);
    ssSetInputPortDirectFeedThrough(S, 0, 1);

    if (!ssSetNumOutputPorts(S,1)) return;
    ssSetOutputPortWidth(S, 0, Ny);
    ssSetNumSampleTimes(S, 1);

    ssSetNumPWork(S,3); // X Delta wsp  vectors
    ssSetNumIWork(S,1); // px 

    
    
    
    
    /* Take care when specifying exception free code - see sfuntmpl_doc.c */
    ssSetOptions(S, SS_OPTION_EXCEPTION_FREE_CODE );
}



/* Function: mdlInitializeSampleTimes =========================================
 * Abstract:
 *    Specifiy that we inherit our sample time from the driving block.
 */
static void mdlInitializeSampleTimes(SimStruct *S)
{
    ssSetSampleTime(S, 0, Ts);
    ssSetOffsetTime(S, 0, 0.0);
}



static void mdlStart(SimStruct *S)
{
int_T i,j;
real_T **tempx;
real_T *Delta=calloc(Nx,sizeof(real_T));
real_T *wsp=calloc(Nx,sizeof(real_T));


    tempx=(real_T**)calloc(Nbuf,sizeof(real_T*));
    if (tempx==NULL){
    printf("Can't allocate memory");
    }
    for (i=0;i<Nbuf;i++){
    tempx[i]=(real_T*)calloc((Nx),sizeof(real_T));
    if (tempx[i]==NULL){
    printf("Can't allocate memory");
    }
    for (j=0;j<Nx;j++)
    tempx[i][j]=0; 
    }
    ssSetPWorkValue(S,0,tempx);
    ssSetPWorkValue(S,1,Delta);
    ssSetPWorkValue(S,2,wsp);
    ssSetIWorkValue(S,0,0);

  
    
 
}



real_T xwy(SimStruct *S,real_T **X,int_T k,int_T px,int_T nr){
real_T xw;  
int_T p=px-k;


if (p>=Nbuf){
    xw=X[p-Nbuf][nr];
    }
else
if (p>=0){
    xw=X[p][nr];
    }
else {
    xw=X[Nbuf+p][nr];
    }

 return xw;
 }



#define MDL_INITIALIZE_CONDITIONS
void mdlInitializeConditions(SimStruct *S){
real_T              **X;
int i,j;
int_T               px=ssGetIWorkValue(S,0);
real_T              *y    = ssGetOutputPortRealSignal(S,0);
X=(real_T**)ssGetPWorkValue(S,0);

for(i=0;i<Nx;i++)
    X[Nbuf-1][i]=X0(i);
    
    
}



/* Function: mdlOutputs =======================================================
 */
 
static void mdlOutputs(SimStruct *S, int_T tid)
{
 
    
    int_T               i,j;
    InputRealPtrsType   uPtrs = ssGetInputPortRealSignalPtrs(S,0);
    real_T              *y    = ssGetOutputPortRealSignal(S,0);
    int_T               width = ssGetOutputPortWidth(S,0);
    int_T               px=ssGetIWorkValue(S,0);
    real_T              **X;
    real_T *Delta=(real_T*)ssGetPWorkValue(S,1);
    real_T *wsp=(real_T*)ssGetPWorkValue(S,2);
  
    X=(real_T**)ssGetPWorkValue(S,0);
    
    
    
    
 


for (i=0;i<Nx;i++)
{
    Delta[i]=0;
    for (j=0;j<Nx;j++)
    {
        Delta[i]+=A(i,j)*xwy(S,X,1,px,j);
    }
    


    for (j=0;j<Nu;j++)
       Delta[i]+=B(i,j)*(*uPtrs[j]);

    
   //Delta[i]*=pow(Ts,N(i,0));
   wsp[i]=1;
   X[px][i]=Delta[i];
   for (j=1;j<Nbuf;j++)
   {
            wsp[i]=wsp[i]*(N(i,0)-j+1.0)/j;
           X[px][i]=X[px][i]-pow(-1,j)*wsp[i]*xwy(S,X,j,px,i);
   }

}
    
    
       
for (i=0;i<Ny;i++)
{
    y[i]=0;
    for (j=0;j<Nx;j++){
        y[i]+=C(i,j)*xwy(S,X,0,px,j);
    } 

}   
    
if (++px>=Nbuf){
    px=0;
   }
 
ssSetIWorkValue(S,0,px);

}




/* Function: mdlTerminate =====================================================
 * Abstract:
 *    No termination needed, but we are required to have this routine.
 */
static void mdlTerminate(SimStruct *S)
{
int_T i;
real_T **temp=(real_T**)ssGetPWorkValue(S,0);
real_T *Delta=(real_T*)ssGetPWorkValue(S,1);
real_T *wsp=(real_T*)ssGetPWorkValue(S,2);



for (i=0;i<Nbuf;i++)
free(temp[i]);
free(temp);
free(Delta);
free(wsp);

}



#ifdef  MATLAB_MEX_FILE    /* Is this file being compiled as a MEX-file? */
#include "simulink.c"      /* MEX-file interface mechanism */
#else
#include "cg_sfun.h"       /* Code generation registration function */
#endif

