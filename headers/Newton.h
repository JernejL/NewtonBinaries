
#ifndef __NEWTON_H__
#define __NEWTON_H__
#define NEWTON_MAJOR_VERSION 3 
#define NEWTON_MINOR_VERSION 15 
#include <dgTypes.h>
#ifdef _NEWTON_STATIC_LIB
	#define NEWTON_API DG_LIBRARY_STATIC
#elif defined(_NEWTON_BUILD_DLL)
	#define NEWTON_API DG_LIBRARY_EXPORT
#else
	#define NEWTON_API DG_LIBRARY_IMPORT
#endif
#ifndef dLong
	#define dLong long long		
#endif
#ifndef dFloat
	#ifdef _NEWTON_USE_DOUBLE
		#define dFloat double
	#else
		#define dFloat float
	#endif
#endif
#ifndef dFloat32
	#define dFloat32 float
#endif
#ifndef dFloat64
	#define dFloat64 double
#endif
#ifdef __cplusplus 
extern "C" {
#endif
	#define NEWTON_BROADPHASE_DEFAULT						0
	#define NEWTON_BROADPHASE_PERSINTENT					1
	#define NEWTON_DYNAMIC_BODY								0
	#define NEWTON_KINEMATIC_BODY							1
	#define NEWTON_DYNAMIC_ASYMETRIC_BODY					2
	#define SERIALIZE_ID_SPHERE								0
	#define SERIALIZE_ID_CAPSULE							1
	#define SERIALIZE_ID_CYLINDER							2
	#define SERIALIZE_ID_CHAMFERCYLINDER					3
	#define SERIALIZE_ID_BOX								4	
	#define SERIALIZE_ID_CONE								5
	#define SERIALIZE_ID_CONVEXHULL							6
	#define SERIALIZE_ID_NULL								7
	#define SERIALIZE_ID_COMPOUND							8
	#define SERIALIZE_ID_TREE								9
	#define SERIALIZE_ID_HEIGHTFIELD						10
	#define SERIALIZE_ID_CLOTH_PATCH						11
	#define SERIALIZE_ID_DEFORMABLE_SOLID					12
	#define SERIALIZE_ID_USERMESH							13
	#define SERIALIZE_ID_SCENE								14
	#define SERIALIZE_ID_FRACTURED_COMPOUND					15
#ifdef __cplusplus
	class NewtonMesh;
	class NewtonBody;
	class NewtonWorld;
	class NewtonJoint;
	class NewtonMaterial;
	class NewtonCollision;
	class NewtonDeformableMeshSegment;
	class NewtonFracturedCompoundMeshPart;
#else
	typedef struct NewtonMesh{} NewtonMesh;
	typedef struct NewtonBody{} NewtonBody;
	typedef struct NewtonWorld{} NewtonWorld;
	typedef struct NewtonJoint{} NewtonJoint;
	typedef struct NewtonMaterial{} NewtonMaterial;
	typedef struct NewtonCollision{} NewtonCollision;
	typedef struct NewtonDeformableMeshSegment{} NewtonDeformableMeshSegment;
	typedef struct NewtonFracturedCompoundMeshPart{} NewtonFracturedCompoundMeshPart;
#endif
	typedef union 
	{
		void* m_ptr;
		dLong m_int;
		dFloat m_float;
	} NewtonMaterialData;
	typedef struct NewtonCollisionMaterial
	{
		dLong m_userId;
		NewtonMaterialData m_userData;
		NewtonMaterialData m_userParam[6];
	} NewtonCollisionMaterial;
	typedef struct NewtonBoxParam
	{
		dFloat m_x;
		dFloat m_y;
		dFloat m_z;
	} NewtonBoxParam;
	typedef struct NewtonSphereParam
	{
		dFloat m_radio;
	} NewtonSphereParam;
	typedef struct NewtonCapsuleParam
	{
		dFloat m_radio0;
		dFloat m_radio1;
		dFloat m_height;
	} NewtonCapsuleParam;
	typedef struct NewtonCylinderParam
	{
		dFloat m_radio0;
		dFloat m_radio1;
		dFloat m_height;
	} NewtonCylinderParam;
	typedef struct NewtonConeParam
	{
		dFloat m_radio;
		dFloat m_height;
	} NewtonConeParam;
	typedef struct NewtonChamferCylinderParam
	{
		dFloat m_radio;
		dFloat m_height;
	} NewtonChamferCylinderParam;
	typedef struct NewtonConvexHullParam
	{
		int m_vertexCount;
		int m_vertexStrideInBytes;
		int m_faceCount;
		dFloat* m_vertex;
	} NewtonConvexHullParam;
	typedef struct NewtonCompoundCollisionParam
	{
		int m_chidrenCount;
	} NewtonCompoundCollisionParam;
	typedef struct NewtonCollisionTreeParam
	{
		int m_vertexCount;
		int m_indexCount;
	} NewtonCollisionTreeParam;
	typedef struct NewtonDeformableMeshParam
	{
		int m_vertexCount;
		int m_triangleCount;
		int m_vrtexStrideInBytes;
		unsigned short *m_indexList;
		dFloat *m_vertexList;
	} NewtonDeformableMeshParam;
	typedef struct NewtonHeightFieldCollisionParam
	{
		int m_width;
		int m_height;
		int m_gridsDiagonals;
		int m_elevationDataType;	
		dFloat m_verticalScale;
		dFloat m_horizonalScale_x;
		dFloat m_horizonalScale_z;
		void* m_vertialElevation;
		char* m_atributes;
	} NewtonHeightFieldCollisionParam;
	typedef struct NewtonSceneCollisionParam
	{
		int m_childrenProxyCount;
	} NewtonSceneCollisionParam;
	typedef struct NewtonCollisionInfoRecord
	{
		dFloat m_offsetMatrix[4][4];
		NewtonCollisionMaterial m_collisionMaterial;
		int m_collisionType;				
		union {
			NewtonBoxParam m_box;									
			NewtonConeParam m_cone;
			NewtonSphereParam m_sphere;
			NewtonCapsuleParam m_capsule;
			NewtonCylinderParam m_cylinder;
			NewtonChamferCylinderParam m_chamferCylinder;
			NewtonConvexHullParam m_convexHull;
			NewtonDeformableMeshParam m_deformableMesh;
			NewtonCompoundCollisionParam m_compoundCollision;
			NewtonCollisionTreeParam m_collisionTree;
			NewtonHeightFieldCollisionParam m_heightField;
			NewtonSceneCollisionParam m_sceneCollision;
			dFloat m_paramArray[64];		    
		};
	} NewtonCollisionInfoRecord;
	typedef struct NewtonJointRecord
	{
		dFloat m_attachmenMatrix_0[4][4];
		dFloat m_attachmenMatrix_1[4][4];
		dFloat m_minLinearDof[3];
		dFloat m_maxLinearDof[3];
		dFloat m_minAngularDof[3];
		dFloat m_maxAngularDof[3];
		const NewtonBody* m_attachBody_0;
		const NewtonBody* m_attachBody_1;
		dFloat m_extraParameters[64];
		int	m_bodiesCollisionOn;
		char m_descriptionType[128];
	} NewtonJointRecord;
	typedef struct NewtonUserMeshCollisionCollideDesc
	{
		dFloat m_boxP0[4];							
		dFloat m_boxP1[4];							
		dFloat m_boxDistanceTravel[4];				
		int m_threadNumber;							
		int	m_faceCount;                        	
		int m_vertexStrideInBytes;              	
		dFloat m_skinThickness;                     
		void* m_userData;                       	
		NewtonBody* m_objBody;                  	
		NewtonBody* m_polySoupBody;             	
		NewtonCollision* m_objCollision;			
		NewtonCollision* m_polySoupCollision;		
		dFloat* m_vertex;                       	
		int* m_faceIndexCount;                  	
		int* m_faceVertexIndex;                 	
	} NewtonUserMeshCollisionCollideDesc;
	typedef struct NewtonWorldConvexCastReturnInfo
	{
		dFloat m_point[4];						
		dFloat m_normal[4];						
		dLong m_contactID;						
		const NewtonBody* m_hitBody;			
		dFloat m_penetration;                   
	} NewtonWorldConvexCastReturnInfo;
	typedef struct NewtonUserMeshCollisionRayHitDesc
	{
		dFloat m_p0[4];							
		dFloat m_p1[4];                         
		dFloat m_normalOut[4];					
		dLong m_userIdOut;						
		void* m_userData;                       
	} NewtonUserMeshCollisionRayHitDesc;
	typedef struct NewtonHingeSliderUpdateDesc
	{
		dFloat m_accel;
		dFloat m_minFriction;
		dFloat m_maxFriction;
		dFloat m_timestep;
	} NewtonHingeSliderUpdateDesc;
	typedef struct NewtonUserContactPoint
	{
		dFloat m_point[4];
		dFloat m_normal[4];
		dLong m_shapeId0;
		dLong m_shapeId1;
		dFloat m_penetration;
		int m_unused[3];
	} NewtonUserContactPoint;
	typedef struct NewtonImmediateModeConstraint
	{
		dFloat m_jacobian01[8][6];
		dFloat m_jacobian10[8][6];
		dFloat m_minFriction[8];
		dFloat m_maxFriction[8];
		dFloat m_jointAccel[8];
		dFloat m_jointStiffness[8];
	} NewtonConstraintDescriptor;
	typedef struct NewtonMeshDoubleData
	{
		dFloat64* m_data;
		int* m_indexList;
		int m_strideInBytes;
	} NewtonMeshDoubleData;
	typedef struct NewtonMeshFloatData
	{
		dFloat* m_data;
		int* m_indexList;
		int m_strideInBytes;
	} NewtonMeshFloatData;
	typedef struct NewtonMeshVertexFormat
	{
		int m_faceCount;
		int* m_faceIndexCount;
		int* m_faceMaterial;
		NewtonMeshDoubleData m_vertex;
		NewtonMeshFloatData m_normal;
		NewtonMeshFloatData m_binormal;
		NewtonMeshFloatData m_uv0;
		NewtonMeshFloatData m_uv1;
		NewtonMeshFloatData m_vertexColor;
	} NewtonMeshVertexFormat;
	typedef void* (*NewtonAllocMemory) (int sizeInBytes);
	typedef void (*NewtonFreeMemory) (void* const ptr, int sizeInBytes);
	typedef void (*NewtonWorldDestructorCallback) (const NewtonWorld* const world);
	typedef void (*NewtonPostUpdateCallback) (const NewtonWorld* const world, dFloat timestep);
	typedef void (*NewtonCreateContactCallback) (const NewtonWorld* const newtonWorld, NewtonJoint* const contact);
	typedef void (*NewtonDestroyContactCallback) (const NewtonWorld* const newtonWorld, NewtonJoint* const contact);
	typedef void (*NewtonWorldListenerDebugCallback) (const NewtonWorld* const world, void* const listener, void* const debugContext);
	typedef void (*NewtonWorldListenerBodyDestroyCallback) (const NewtonWorld* const world, void* const listenerUserData, NewtonBody* const body);
	typedef void (*NewtonWorldUpdateListenerCallback) (const NewtonWorld* const world, void* const listenerUserData, dFloat timestep);
	typedef void (*NewtonWorldDestroyListenerCallback) (const NewtonWorld* const world, void* const listenerUserData);
	typedef dLong (*NewtonGetTimeInMicrosencondsCallback) ();
	typedef void (*NewtonSerializeCallback) (void* const serializeHandle, const void* const buffer, int size);
	typedef void (*NewtonDeserializeCallback) (void* const serializeHandle, void* const buffer, int size);
	typedef void (*NewtonOnBodySerializationCallback) (NewtonBody* const body, void* const userData, NewtonSerializeCallback function, void* const serializeHandle);
	typedef void (*NewtonOnBodyDeserializationCallback) (NewtonBody* const body, void* const userData, NewtonDeserializeCallback function, void* const serializeHandle);
	typedef void (*NewtonOnJointSerializationCallback) (const NewtonJoint* const joint, NewtonSerializeCallback function, void* const serializeHandle);
	typedef void (*NewtonOnJointDeserializationCallback) (NewtonBody* const body0, NewtonBody* const body1, NewtonDeserializeCallback function, void* const serializeHandle);
	typedef void (*NewtonOnUserCollisionSerializationCallback) (void* const userData, NewtonSerializeCallback function, void* const serializeHandle);
	typedef void (*NewtonUserMeshCollisionDestroyCallback) (void* const userData);
	typedef dFloat (*NewtonUserMeshCollisionRayHitCallback) (NewtonUserMeshCollisionRayHitDesc* const lineDescData);
	typedef void (*NewtonUserMeshCollisionGetCollisionInfo) (void* const userData, NewtonCollisionInfoRecord* const infoRecord);
	typedef int (*NewtonUserMeshCollisionAABBTest) (void* const userData, const dFloat* const boxP0, const dFloat* const boxP1);
	typedef int (*NewtonUserMeshCollisionGetFacesInAABB) (void* const userData, const dFloat* const p0, const dFloat* const p1,
														   const dFloat** const vertexArray, int* const vertexCount, int* const vertexStrideInBytes, 
		                                                   const int* const indexList, int maxIndexCount, const int* const userDataList);
	typedef void (*NewtonUserMeshCollisionCollideCallback) (NewtonUserMeshCollisionCollideDesc* const collideDescData, const void* const continueCollisionHandle);
	typedef int (*NewtonTreeCollisionFaceCallback) (void* const context, const dFloat* const polygon, int strideInBytes, const int* const indexArray, int indexCount);
	typedef dFloat (*NewtonCollisionTreeRayCastCallback) (const NewtonBody* const body, const NewtonCollision* const treeCollision, dFloat intersection, dFloat* const normal, int faceId, void* const usedData);
	typedef dFloat (*NewtonHeightFieldRayCastCallback) (const NewtonBody* const body, const NewtonCollision* const heightFieldCollision, dFloat intersection, int row, int col, dFloat* const normal, int faceId, void* const usedData);
	typedef void (*NewtonCollisionCopyConstructionCallback) (const NewtonWorld* const newtonWorld, NewtonCollision* const collision, const NewtonCollision* const sourceCollision);
	typedef void (*NewtonCollisionDestructorCallback) (const NewtonWorld* const newtonWorld, const NewtonCollision* const collision);
	typedef void (*NewtonTreeCollisionCallback) (const NewtonBody* const bodyWithTreeCollision, const NewtonBody* const body, int faceID, 
												 int vertexCount, const dFloat* const vertex, int vertexStrideInBytes); 
	typedef void (*NewtonBodyDestructor) (const NewtonBody* const body);
	typedef void (*NewtonApplyForceAndTorque) (const NewtonBody* const body, dFloat timestep, int threadIndex);
	typedef void (*NewtonSetTransform) (const NewtonBody* const body, const dFloat* const matrix, int threadIndex);
	typedef int (*NewtonIslandUpdate) (const NewtonWorld* const newtonWorld, const void* islandHandle, int bodyCount);
	typedef void (*NewtonFractureCompoundCollisionOnEmitCompoundFractured) (NewtonBody* const fracturedBody);
	typedef void (*NewtonFractureCompoundCollisionOnEmitChunk) (NewtonBody* const chunkBody, NewtonFracturedCompoundMeshPart* const fracturexChunkMesh, const NewtonCollision* const fracturedCompountCollision);
	typedef void (*NewtonFractureCompoundCollisionReconstructMainMeshCallBack) (NewtonBody* const body, NewtonFracturedCompoundMeshPart* const mainMesh, const NewtonCollision* const fracturedCompountCollision);
	typedef unsigned (*NewtonWorldRayPrefilterCallback)(const NewtonBody* const body, const NewtonCollision* const collision, void* const userData);
	typedef dFloat (*NewtonWorldRayFilterCallback)(const NewtonBody* const body, const NewtonCollision* const shapeHit, const dFloat* const hitContact, const dFloat* const hitNormal, dLong collisionID, void* const userData, dFloat intersectParam);
	typedef int (*NewtonOnAABBOverlap) (const NewtonJoint* const contact, dFloat timestep, int threadIndex);
	typedef void (*NewtonContactsProcess) (const NewtonJoint* const contact, dFloat timestep, int threadIndex);
	typedef int (*NewtonOnCompoundSubCollisionAABBOverlap) (const NewtonJoint* const contact, dFloat timestep, const NewtonBody* const body0, const void* const collisionNode0, const NewtonBody* const body1, const void* const collisionNode1, int threadIndex);
	typedef int  (*NewtonOnContactGeneration) (const NewtonMaterial* const material, const NewtonBody* const body0, const NewtonCollision* const collision0, const NewtonBody* const body1, const NewtonCollision* const collision1, NewtonUserContactPoint* const contactBuffer, int maxCount, int threadIndex);
	typedef int (*NewtonBodyIterator) (const NewtonBody* const body, void* const userData);
	typedef void (*NewtonJointIterator) (const NewtonJoint* const joint, void* const userData);
	typedef void (*NewtonCollisionIterator) (void* const userData, int vertexCount, const dFloat* const faceArray, int faceId);
	typedef void (*NewtonBallCallback) (const NewtonJoint* const ball, dFloat timestep);
	typedef unsigned (*NewtonHingeCallback) (const NewtonJoint* const hinge, NewtonHingeSliderUpdateDesc* const desc);
	typedef unsigned (*NewtonSliderCallback) (const NewtonJoint* const slider, NewtonHingeSliderUpdateDesc* const desc);
	typedef unsigned (*NewtonUniversalCallback) (const NewtonJoint* const universal, NewtonHingeSliderUpdateDesc* const desc);
	typedef unsigned (*NewtonCorkscrewCallback) (const NewtonJoint* const corkscrew, NewtonHingeSliderUpdateDesc* const desc);
	typedef void (*NewtonUserBilateralCallback) (const NewtonJoint* const userJoint, dFloat timestep, int threadIndex);
	typedef void (*NewtonUserBilateralGetInfoCallback) (const NewtonJoint* const userJoint, NewtonJointRecord* const info);
	typedef void (*NewtonConstraintDestructor) (const NewtonJoint* const me);
	typedef void (*NewtonJobTask) (NewtonWorld* const world, void* const userData, int threadIndex);
	typedef int (*NewtonReportProgress) (dFloat normalizedProgressPercent, void* const userData);
	:CATEGORY:1: 
	:CATEGORY:1:  world control functions
	:CATEGORY:1: 
	NEWTON_API int NewtonWorldGetVersion ();
	NEWTON_API int NewtonWorldFloatSize ();
	NEWTON_API int NewtonGetMemoryUsed ();
	NEWTON_API void NewtonSetMemorySystem (NewtonAllocMemory malloc, NewtonFreeMemory free);
	NEWTON_API NewtonWorld* NewtonCreate ();
	NEWTON_API void NewtonDestroy (const NewtonWorld* const newtonWorld);
	NEWTON_API void NewtonDestroyAllBodies (const NewtonWorld* const newtonWorld);
	NEWTON_API NewtonPostUpdateCallback NewtonGetPostUpdateCallback(const NewtonWorld* const newtonWorld);
	NEWTON_API void NewtonSetPostUpdateCallback (const NewtonWorld* const newtonWorld, NewtonPostUpdateCallback callback);
	NEWTON_API void* NewtonAlloc (int sizeInBytes);
	NEWTON_API void NewtonFree (void* const ptr);
	NEWTON_API void NewtonLoadPlugins(const NewtonWorld* const newtonWorld, const char* const plugInPath);
	NEWTON_API void NewtonUnloadPlugins(const NewtonWorld* const newtonWorld);
	NEWTON_API void* NewtonCurrentPlugin(const NewtonWorld* const newtonWorld);
	NEWTON_API void* NewtonGetFirstPlugin(const NewtonWorld* const newtonWorld);
	NEWTON_API void* NewtonGetPreferedPlugin(const NewtonWorld* const newtonWorld);
	NEWTON_API void* NewtonGetNextPlugin(const NewtonWorld* const newtonWorld, const void* const plugin);
	NEWTON_API const char* NewtonGetPluginString(const NewtonWorld* const newtonWorld, const void* const plugin);
	NEWTON_API void NewtonSelectPlugin(const NewtonWorld* const newtonWorld, const void* const plugin);
	NEWTON_API dFloat NewtonGetContactMergeTolerance (const NewtonWorld* const newtonWorld);
	NEWTON_API void NewtonSetContactMergeTolerance (const NewtonWorld* const newtonWorld, dFloat tolerance);
	NEWTON_API void NewtonInvalidateCache (const NewtonWorld* const newtonWorld);
	NEWTON_API void NewtonSetSolverIterations (const NewtonWorld* const newtonWorld, int model);
	NEWTON_API int NewtonGetSolverIterations(const NewtonWorld* const newtonWorld);
	NEWTON_API void NewtonSetParallelSolverOnLargeIsland (const NewtonWorld* const newtonWorld, int mode);
	NEWTON_API int NewtonGetParallelSolverOnLargeIsland (const NewtonWorld* const newtonWorld);
	NEWTON_API int NewtonGetBroadphaseAlgorithm (const NewtonWorld* const newtonWorld);
	NEWTON_API void NewtonSelectBroadphaseAlgorithm (const NewtonWorld* const newtonWorld, int algorithmType);
	NEWTON_API void NewtonResetBroadphase(const NewtonWorld* const newtonWorld);
	NEWTON_API void NewtonUpdate (const NewtonWorld* const newtonWorld, dFloat timestep);
	NEWTON_API void NewtonUpdateAsync (const NewtonWorld* const newtonWorld, dFloat timestep);
	NEWTON_API void NewtonWaitForUpdateToFinish (const NewtonWorld* const newtonWorld);
	NEWTON_API int NewtonGetNumberOfSubsteps (const NewtonWorld* const newtonWorld);
	NEWTON_API void NewtonSetNumberOfSubsteps (const NewtonWorld* const newtonWorld, int subSteps);
	NEWTON_API dFloat NewtonGetLastUpdateTime (const NewtonWorld* const newtonWorld);
	NEWTON_API void NewtonSerializeToFile (const NewtonWorld* const newtonWorld, const char* const filename, NewtonOnBodySerializationCallback bodyCallback, void* const bodyUserData);
	NEWTON_API void NewtonDeserializeFromFile (const NewtonWorld* const newtonWorld, const char* const filename, NewtonOnBodyDeserializationCallback bodyCallback, void* const bodyUserData);
	NEWTON_API void NewtonSerializeScene(const NewtonWorld* const newtonWorld, NewtonOnBodySerializationCallback bodyCallback, void* const bodyUserData,
									   	 NewtonSerializeCallback serializeCallback, void* const serializeHandle);
	NEWTON_API void NewtonDeserializeScene(const NewtonWorld* const newtonWorld, NewtonOnBodyDeserializationCallback bodyCallback, void* const bodyUserData,
										   NewtonDeserializeCallback serializeCallback, void* const serializeHandle);
	NEWTON_API NewtonBody* NewtonFindSerializedBody(const NewtonWorld* const newtonWorld, int bodySerializedID);
	NEWTON_API void NewtonSetJointSerializationCallbacks (const NewtonWorld* const newtonWorld, NewtonOnJointSerializationCallback serializeJoint, NewtonOnJointDeserializationCallback deserializeJoint);
	NEWTON_API void NewtonGetJointSerializationCallbacks (const NewtonWorld* const newtonWorld, NewtonOnJointSerializationCallback* const serializeJoint, NewtonOnJointDeserializationCallback* const deserializeJoint);
	NEWTON_API void NewtonWorldCriticalSectionLock (const NewtonWorld* const newtonWorld, int threadIndex);
	NEWTON_API void NewtonWorldCriticalSectionUnlock (const NewtonWorld* const newtonWorld);
	NEWTON_API void NewtonSetThreadsCount (const NewtonWorld* const newtonWorld, int threads);
	NEWTON_API int NewtonGetThreadsCount(const NewtonWorld* const newtonWorld);
	NEWTON_API int NewtonGetMaxThreadsCount(const NewtonWorld* const newtonWorld);
	NEWTON_API void NewtonDispachThreadJob(const NewtonWorld* const newtonWorld, NewtonJobTask task, void* const usedData, const char* const functionName);
	NEWTON_API void NewtonSyncThreadJobs(const NewtonWorld* const newtonWorld);
	NEWTON_API int NewtonAtomicAdd (int* const ptr, int value);
	NEWTON_API int NewtonAtomicSwap (int* const ptr, int value);
	NEWTON_API void NewtonYield ();
	NEWTON_API void NewtonSetIslandUpdateEvent (const NewtonWorld* const newtonWorld, NewtonIslandUpdate islandUpdate); 
	NEWTON_API void NewtonWorldForEachJointDo (const NewtonWorld* const newtonWorld, NewtonJointIterator callback, void* const userData);
	NEWTON_API void NewtonWorldForEachBodyInAABBDo (const NewtonWorld* const newtonWorld, const dFloat* const p0, const dFloat* const p1, NewtonBodyIterator callback, void* const userData);
	NEWTON_API void NewtonWorldSetUserData (const NewtonWorld* const newtonWorld, void* const userData);
	NEWTON_API void* NewtonWorldGetUserData (const NewtonWorld* const newtonWorld);
	NEWTON_API void* NewtonWorldAddListener (const NewtonWorld* const newtonWorld, const char* const nameId, void* const listenerUserData);
	NEWTON_API void* NewtonWorldGetListener (const NewtonWorld* const newtonWorld, const char* const nameId);
	NEWTON_API void NewtonWorldListenerSetDebugCallback (const NewtonWorld* const newtonWorld, void* const listener, NewtonWorldListenerDebugCallback callback);
	NEWTON_API void NewtonWorldListenerSetPostStepCallback (const NewtonWorld* const newtonWorld, void* const listener, NewtonWorldUpdateListenerCallback callback);
	NEWTON_API void NewtonWorldListenerSetPreUpdateCallback (const NewtonWorld* const newtonWorld, void* const listener, NewtonWorldUpdateListenerCallback callback);
	NEWTON_API void NewtonWorldListenerSetPostUpdateCallback (const NewtonWorld* const newtonWorld, void* const listener, NewtonWorldUpdateListenerCallback callback);
	NEWTON_API void NewtonWorldListenerSetDestructorCallback (const NewtonWorld* const newtonWorld, void* const listener, NewtonWorldDestroyListenerCallback callback);
	NEWTON_API void NewtonWorldListenerSetBodyDestroyCallback(const NewtonWorld* const newtonWorld, void* const listener, NewtonWorldListenerBodyDestroyCallback callback);
	NEWTON_API void NewtonWorldListenerDebug(const NewtonWorld* const newtonWorld, void* const context);
	NEWTON_API void* NewtonWorldGetListenerUserData(const NewtonWorld* const newtonWorld, void* const listener);
	NEWTON_API NewtonWorldListenerBodyDestroyCallback NewtonWorldListenerGetBodyDestroyCallback (const NewtonWorld* const newtonWorld, void* const listener);
	NEWTON_API void NewtonWorldSetDestructorCallback (const NewtonWorld* const newtonWorld, NewtonWorldDestructorCallback destructor);
	NEWTON_API NewtonWorldDestructorCallback NewtonWorldGetDestructorCallback (const NewtonWorld* const newtonWorld);
	NEWTON_API void NewtonWorldSetCollisionConstructorDestructorCallback (const NewtonWorld* const newtonWorld, NewtonCollisionCopyConstructionCallback constructor, NewtonCollisionDestructorCallback destructor);
	NEWTON_API void NewtonWorldSetCreateDestroyContactCallback(const NewtonWorld* const newtonWorld, NewtonCreateContactCallback createContact, NewtonDestroyContactCallback destroyContact);
	NEWTON_API void NewtonWorldRayCast (const NewtonWorld* const newtonWorld, const dFloat* const p0, const dFloat* const p1, NewtonWorldRayFilterCallback filter, void* const userData, NewtonWorldRayPrefilterCallback prefilter, int threadIndex);
	NEWTON_API int NewtonWorldConvexCast (const NewtonWorld* const newtonWorld, const dFloat* const matrix, const dFloat* const target, const NewtonCollision* const shape, dFloat* const param, void* const userData, NewtonWorldRayPrefilterCallback prefilter, NewtonWorldConvexCastReturnInfo* const info, int maxContactsCount, int threadIndex);
	NEWTON_API int NewtonWorldCollide (const NewtonWorld* const newtonWorld, const dFloat* const matrix, const NewtonCollision* const shape, void* const userData, NewtonWorldRayPrefilterCallback prefilter, NewtonWorldConvexCastReturnInfo* const info, int maxContactsCount, int threadIndex);
	NEWTON_API int NewtonWorldGetBodyCount(const NewtonWorld* const newtonWorld);
	NEWTON_API int NewtonWorldGetConstraintCount(const NewtonWorld* const newtonWorld);
	NEWTON_API NewtonJoint* NewtonWorldFindJoint(const NewtonBody* const body0, const NewtonBody* const body1);
	:CATEGORY:3: 
	:CATEGORY:3:  Simulation islands
	:CATEGORY:3: 
	NEWTON_API NewtonBody* NewtonIslandGetBody (const void* const island, int bodyIndex);
	NEWTON_API void NewtonIslandGetBodyAABB (const void* const island, int bodyIndex, dFloat* const p0, dFloat* const p1);
	:CATEGORY:5: 
	:CATEGORY:5:  Physics Material Section
	:CATEGORY:5: 
	NEWTON_API int NewtonMaterialCreateGroupID(const NewtonWorld* const newtonWorld);
	NEWTON_API int NewtonMaterialGetDefaultGroupID(const NewtonWorld* const newtonWorld);
	NEWTON_API void NewtonMaterialDestroyAllGroupID(const NewtonWorld* const newtonWorld);
	NEWTON_API void* NewtonMaterialGetUserData (const NewtonWorld* const newtonWorld, int id0, int id1);
	NEWTON_API void NewtonMaterialSetSurfaceThickness (const NewtonWorld* const newtonWorld, int id0, int id1, dFloat thickness);
	NEWTON_API void NewtonMaterialSetCallbackUserData (const NewtonWorld* const newtonWorld, int id0, int id1, void* const userData);
	NEWTON_API void NewtonMaterialSetContactGenerationCallback (const NewtonWorld* const newtonWorld, int id0, int id1, NewtonOnContactGeneration contactGeneration);
	NEWTON_API void NewtonMaterialSetCompoundCollisionCallback(const NewtonWorld* const newtonWorld, int id0, int id1, NewtonOnCompoundSubCollisionAABBOverlap compoundAabbOverlap);
	NEWTON_API void NewtonMaterialSetCollisionCallback (const NewtonWorld* const newtonWorld, int id0, int id1, NewtonOnAABBOverlap aabbOverlap, NewtonContactsProcess process);
	NEWTON_API void NewtonMaterialSetDefaultSoftness (const NewtonWorld* const newtonWorld, int id0, int id1, dFloat value);
	NEWTON_API void NewtonMaterialSetDefaultElasticity (const NewtonWorld* const newtonWorld, int id0, int id1, dFloat elasticCoef);
	NEWTON_API void NewtonMaterialSetDefaultCollidable (const NewtonWorld* const newtonWorld, int id0, int id1, int state);
	NEWTON_API void NewtonMaterialSetDefaultFriction (const NewtonWorld* const newtonWorld, int id0, int id1, dFloat staticFriction, dFloat kineticFriction);
	NEWTON_API void NewtonMaterialJointResetIntraJointCollision (const NewtonWorld* const newtonWorld, int id0, int id1);
	NEWTON_API void NewtonMaterialJointResetSelftJointCollision (const NewtonWorld* const newtonWorld, int id0, int id1);
	NEWTON_API NewtonMaterial* NewtonWorldGetFirstMaterial (const NewtonWorld* const newtonWorld);
	NEWTON_API NewtonMaterial* NewtonWorldGetNextMaterial (const NewtonWorld* const newtonWorld, const NewtonMaterial* const material);
	NEWTON_API NewtonBody* NewtonWorldGetFirstBody (const NewtonWorld* const newtonWorld);
	NEWTON_API NewtonBody* NewtonWorldGetNextBody (const NewtonWorld* const newtonWorld, const NewtonBody* const curBody);
	:CATEGORY:7: 
	:CATEGORY:7:  Physics Contact control functions
	:CATEGORY:7: 
	NEWTON_API void *NewtonMaterialGetMaterialPairUserData (const NewtonMaterial* const material);
	NEWTON_API unsigned NewtonMaterialGetContactFaceAttribute (const NewtonMaterial* const material);
	NEWTON_API NewtonCollision* NewtonMaterialGetBodyCollidingShape (const NewtonMaterial* const material, const NewtonBody* const body);
	NEWTON_API dFloat NewtonMaterialGetContactNormalSpeed (const NewtonMaterial* const material);
	NEWTON_API void NewtonMaterialGetContactForce (const NewtonMaterial* const material, const NewtonBody* const body, dFloat* const force);
	NEWTON_API void NewtonMaterialGetContactPositionAndNormal (const NewtonMaterial* const material, const NewtonBody* const body, dFloat* const posit, dFloat* const normal);
	NEWTON_API void NewtonMaterialGetContactTangentDirections (const NewtonMaterial* const material, const NewtonBody* const body, dFloat* const dir0, dFloat* const dir1);
	NEWTON_API dFloat NewtonMaterialGetContactTangentSpeed (const NewtonMaterial* const material, int index);
	NEWTON_API dFloat NewtonMaterialGetContactMaxNormalImpact (const NewtonMaterial* const material);
	NEWTON_API dFloat NewtonMaterialGetContactMaxTangentImpact (const NewtonMaterial* const material, int index);
	NEWTON_API dFloat NewtonMaterialGetContactPenetration (const NewtonMaterial* const material);
	NEWTON_API void NewtonMaterialSetAsSoftContact (const NewtonMaterial* const material, dFloat relaxation);
	NEWTON_API void NewtonMaterialSetContactSoftness (const NewtonMaterial* const material, dFloat softness);
	NEWTON_API void NewtonMaterialSetContactThickness (const NewtonMaterial* const material, dFloat thickness);
	NEWTON_API void NewtonMaterialSetContactElasticity (const NewtonMaterial* const material, dFloat restitution);
	NEWTON_API void NewtonMaterialSetContactFrictionState (const NewtonMaterial* const material, int state, int index);
	NEWTON_API void NewtonMaterialSetContactFrictionCoef (const NewtonMaterial* const material, dFloat staticFrictionCoef, dFloat kineticFrictionCoef, int index);
	NEWTON_API void NewtonMaterialSetContactNormalAcceleration (const NewtonMaterial* const material, dFloat accel);
	NEWTON_API void NewtonMaterialSetContactNormalDirection (const NewtonMaterial* const material, const dFloat* const directionVector);
	NEWTON_API void NewtonMaterialSetContactPosition (const NewtonMaterial* const material, const dFloat* const position);
	NEWTON_API void NewtonMaterialSetContactTangentFriction (const NewtonMaterial* const material, dFloat friction, int index);
	NEWTON_API void NewtonMaterialSetContactTangentAcceleration (const NewtonMaterial* const material, dFloat accel, int index);
	NEWTON_API void NewtonMaterialContactRotateTangentDirections (const NewtonMaterial* const material, const dFloat* const directionVector);
	NEWTON_API dFloat NewtonMaterialGetContactPruningTolerance(const NewtonJoint* const contactJoint);
	NEWTON_API void NewtonMaterialSetContactPruningTolerance(const NewtonJoint* const contactJoint, dFloat tolerance);
	:CATEGORY:9: 
	:CATEGORY:9:  convex collision primitives creation functions
	:CATEGORY:9: 
	NEWTON_API NewtonCollision* NewtonCreateNull (const NewtonWorld* const newtonWorld);
	NEWTON_API NewtonCollision* NewtonCreateSphere (const NewtonWorld* const newtonWorld, dFloat radius, int shapeID, const dFloat* const offsetMatrix);
	NEWTON_API NewtonCollision* NewtonCreateBox (const NewtonWorld* const newtonWorld, dFloat dx, dFloat dy, dFloat dz, int shapeID, const dFloat* const offsetMatrix);
	NEWTON_API NewtonCollision* NewtonCreateCone (const NewtonWorld* const newtonWorld, dFloat radius, dFloat height, int shapeID, const dFloat* const offsetMatrix);
	NEWTON_API NewtonCollision* NewtonCreateCapsule (const NewtonWorld* const newtonWorld, dFloat radius0, dFloat radius1, dFloat height, int shapeID, const dFloat* const offsetMatrix);
	NEWTON_API NewtonCollision* NewtonCreateCylinder (const NewtonWorld* const newtonWorld, dFloat radio0, dFloat radio1, dFloat height, int shapeID, const dFloat* const offsetMatrix);
	NEWTON_API NewtonCollision* NewtonCreateChamferCylinder (const NewtonWorld* const newtonWorld, dFloat radius, dFloat height, int shapeID, const dFloat* const offsetMatrix);
	NEWTON_API NewtonCollision* NewtonCreateConvexHull (const NewtonWorld* const newtonWorld, int count, const dFloat* const vertexCloud, int strideInBytes, dFloat tolerance, int shapeID, const dFloat* const offsetMatrix);
	NEWTON_API NewtonCollision* NewtonCreateConvexHullFromMesh (const NewtonWorld* const newtonWorld, const NewtonMesh* const mesh, dFloat tolerance, int shapeID);
	NEWTON_API int NewtonCollisionGetMode(const NewtonCollision* const convexCollision);
	NEWTON_API void NewtonCollisionSetMode (const NewtonCollision* const convexCollision, int mode);
	NEWTON_API int NewtonConvexHullGetFaceIndices (const NewtonCollision* const convexHullCollision, int face, int* const faceIndices);
	NEWTON_API int NewtonConvexHullGetVertexData (const NewtonCollision* const convexHullCollision, dFloat** const vertexData, int* strideInBytes);
	NEWTON_API dFloat NewtonConvexCollisionCalculateVolume (const NewtonCollision* const convexCollision);
	NEWTON_API void NewtonConvexCollisionCalculateInertialMatrix (const NewtonCollision* convexCollision, dFloat* const inertia, dFloat* const origin);	
	NEWTON_API dFloat NewtonConvexCollisionCalculateBuoyancyVolume (const NewtonCollision* const convexCollision, const dFloat* const matrix, const dFloat* const fluidPlane, dFloat* const centerOfBuoyancy);
	NEWTON_API const void* NewtonCollisionDataPointer (const NewtonCollision* const convexCollision);
	:CATEGORY:11: 
	:CATEGORY:11:  compound collision primitives creation functions
	:CATEGORY:11: 
	NEWTON_API NewtonCollision* NewtonCreateCompoundCollision (const NewtonWorld* const newtonWorld, int shapeID);
	NEWTON_API NewtonCollision* NewtonCreateCompoundCollisionFromMesh (const NewtonWorld* const newtonWorld, const NewtonMesh* const mesh, dFloat hullTolerance, int shapeID, int subShapeID);
	NEWTON_API void NewtonCompoundCollisionBeginAddRemove (NewtonCollision* const compoundCollision);	
	NEWTON_API void* NewtonCompoundCollisionAddSubCollision (NewtonCollision* const compoundCollision, const NewtonCollision* const convexCollision);	
	NEWTON_API void NewtonCompoundCollisionRemoveSubCollision (NewtonCollision* const compoundCollision, const void* const collisionNode);	
	NEWTON_API void NewtonCompoundCollisionRemoveSubCollisionByIndex (NewtonCollision* const compoundCollision, int nodeIndex);	
	NEWTON_API void NewtonCompoundCollisionSetSubCollisionMatrix (NewtonCollision* const compoundCollision, const void* const collisionNode, const dFloat* const matrix);	
	NEWTON_API void NewtonCompoundCollisionEndAddRemove (NewtonCollision* const compoundCollision);	
	NEWTON_API void* NewtonCompoundCollisionGetFirstNode (NewtonCollision* const compoundCollision);
	NEWTON_API void* NewtonCompoundCollisionGetNextNode (NewtonCollision* const compoundCollision, const void* const collisionNode);
	NEWTON_API void* NewtonCompoundCollisionGetNodeByIndex (NewtonCollision* const compoundCollision, int index);
	NEWTON_API int NewtonCompoundCollisionGetNodeIndex (NewtonCollision* const compoundCollision, const void* const collisionNode);
	NEWTON_API NewtonCollision* NewtonCompoundCollisionGetCollisionFromNode (NewtonCollision* const compoundCollision, const void* const collisionNode);
	:CATEGORY:13: 
	:CATEGORY:13:  Fractured compound collision primitives interface
	:CATEGORY:13: 
	NEWTON_API NewtonCollision* NewtonCreateFracturedCompoundCollision (const NewtonWorld* const newtonWorld, const NewtonMesh* const solidMesh, int shapeID, int fracturePhysicsMaterialID, int pointcloudCount, const dFloat* const vertexCloud, int strideInBytes, int materialID, const dFloat* const textureMatrix,
																		NewtonFractureCompoundCollisionReconstructMainMeshCallBack regenerateMainMeshCallback, 
																		NewtonFractureCompoundCollisionOnEmitCompoundFractured emitFracturedCompound, NewtonFractureCompoundCollisionOnEmitChunk emitFracfuredChunk);
	NEWTON_API NewtonCollision* NewtonFracturedCompoundPlaneClip (const NewtonCollision* const fracturedCompound, const dFloat* const plane);
	NEWTON_API void NewtonFracturedCompoundSetCallbacks (const NewtonCollision* const fracturedCompound, NewtonFractureCompoundCollisionReconstructMainMeshCallBack regenerateMainMeshCallback, 
														 NewtonFractureCompoundCollisionOnEmitCompoundFractured emitFracturedCompound, NewtonFractureCompoundCollisionOnEmitChunk emitFracfuredChunk);
	NEWTON_API int NewtonFracturedCompoundIsNodeFreeToDetach (const NewtonCollision* const fracturedCompound, void* const collisionNode);
	NEWTON_API int NewtonFracturedCompoundNeighborNodeList (const NewtonCollision* const fracturedCompound, void* const collisionNode, void** const list, int maxCount);
	NEWTON_API NewtonFracturedCompoundMeshPart* NewtonFracturedCompoundGetMainMesh (const NewtonCollision* const fracturedCompound);
	NEWTON_API NewtonFracturedCompoundMeshPart* NewtonFracturedCompoundGetFirstSubMesh(const NewtonCollision* const fracturedCompound);
	NEWTON_API NewtonFracturedCompoundMeshPart* NewtonFracturedCompoundGetNextSubMesh(const NewtonCollision* const fracturedCompound, NewtonFracturedCompoundMeshPart* const subMesh);
	NEWTON_API int NewtonFracturedCompoundCollisionGetVertexCount (const NewtonCollision* const fracturedCompound, const NewtonFracturedCompoundMeshPart* const meshOwner); 
	NEWTON_API const dFloat* NewtonFracturedCompoundCollisionGetVertexPositions (const NewtonCollision* const fracturedCompound, const NewtonFracturedCompoundMeshPart* const meshOwner);
	NEWTON_API const dFloat* NewtonFracturedCompoundCollisionGetVertexNormals (const NewtonCollision* const fracturedCompound, const NewtonFracturedCompoundMeshPart* const meshOwner);
	NEWTON_API const dFloat* NewtonFracturedCompoundCollisionGetVertexUVs (const NewtonCollision* const fracturedCompound, const NewtonFracturedCompoundMeshPart* const meshOwner);
	NEWTON_API int NewtonFracturedCompoundMeshPartGetIndexStream (const NewtonCollision* const fracturedCompound, const NewtonFracturedCompoundMeshPart* const meshOwner, const void* const segment, int* const index); 
	NEWTON_API void* NewtonFracturedCompoundMeshPartGetFirstSegment (const NewtonFracturedCompoundMeshPart* const fractureCompoundMeshPart); 
	NEWTON_API void* NewtonFracturedCompoundMeshPartGetNextSegment (const void* const fractureCompoundMeshSegment); 
	NEWTON_API int NewtonFracturedCompoundMeshPartGetMaterial (const void* const fractureCompoundMeshSegment); 
	NEWTON_API int NewtonFracturedCompoundMeshPartGetIndexCount (const void* const fractureCompoundMeshSegment); 
	:CATEGORY:15: 
	:CATEGORY:15:  scene collision are static compound collision that can take polygonal static collisions
	:CATEGORY:15: 
	NEWTON_API NewtonCollision* NewtonCreateSceneCollision (const NewtonWorld* const newtonWorld, int shapeID);
	NEWTON_API void NewtonSceneCollisionBeginAddRemove (NewtonCollision* const sceneCollision);	
	NEWTON_API void* NewtonSceneCollisionAddSubCollision (NewtonCollision* const sceneCollision, const NewtonCollision* const collision);	
	NEWTON_API void NewtonSceneCollisionRemoveSubCollision (NewtonCollision* const compoundCollision, const void* const collisionNode);	
	NEWTON_API void NewtonSceneCollisionRemoveSubCollisionByIndex (NewtonCollision* const sceneCollision, int nodeIndex);
	NEWTON_API void NewtonSceneCollisionSetSubCollisionMatrix (NewtonCollision* const sceneCollision, const void* const collisionNode, const dFloat* const matrix);	
	NEWTON_API void NewtonSceneCollisionEndAddRemove (NewtonCollision* const sceneCollision);	
	NEWTON_API void* NewtonSceneCollisionGetFirstNode (NewtonCollision* const sceneCollision);
	NEWTON_API void* NewtonSceneCollisionGetNextNode (NewtonCollision* const sceneCollision, const void* const collisionNode);
	NEWTON_API void* NewtonSceneCollisionGetNodeByIndex (NewtonCollision* const sceneCollision, int index);
	NEWTON_API int NewtonSceneCollisionGetNodeIndex (NewtonCollision* const sceneCollision, const void* const collisionNode);
	NEWTON_API NewtonCollision* NewtonSceneCollisionGetCollisionFromNode (NewtonCollision* const sceneCollision, const void* const collisionNode);
	:CATEGORY:17: 
	:CATEGORY:17: 	User Static mesh collision interface
	:CATEGORY:17: 
	NEWTON_API NewtonCollision* NewtonCreateUserMeshCollision (const NewtonWorld* const newtonWorld, const dFloat* const minBox, 
		const dFloat* const maxBox, void* const userData, NewtonUserMeshCollisionCollideCallback collideCallback, 
		NewtonUserMeshCollisionRayHitCallback rayHitCallback, NewtonUserMeshCollisionDestroyCallback destroyCallback,
		NewtonUserMeshCollisionGetCollisionInfo getInfoCallback, NewtonUserMeshCollisionAABBTest getLocalAABBCallback, 
		NewtonUserMeshCollisionGetFacesInAABB facesInAABBCallback, NewtonOnUserCollisionSerializationCallback serializeCallback, int shapeID);
	NEWTON_API int NewtonUserMeshCollisionContinuousOverlapTest (const NewtonUserMeshCollisionCollideDesc* const collideDescData, const void* const continueCollisionHandle, const dFloat* const minAabb, const dFloat* const maxAabb);
	:CATEGORY:19: 
	:CATEGORY:19: 	Collision serialization functions
	:CATEGORY:19: 
	NEWTON_API NewtonCollision* NewtonCreateCollisionFromSerialization (const NewtonWorld* const newtonWorld, NewtonDeserializeCallback deserializeFunction, void* const serializeHandle);
	NEWTON_API void NewtonCollisionSerialize (const NewtonWorld* const newtonWorld, const NewtonCollision* const collision, NewtonSerializeCallback serializeFunction, void* const serializeHandle);
	NEWTON_API void NewtonCollisionGetInfo (const NewtonCollision* const collision, NewtonCollisionInfoRecord* const collisionInfo);
	:CATEGORY:21: 
	:CATEGORY:21:  Static collision shapes functions
	:CATEGORY:21: 
	NEWTON_API NewtonCollision* NewtonCreateHeightFieldCollision (const NewtonWorld* const newtonWorld, int width, int height, int gridsDiagonals, int elevationdatType, const void* const elevationMap, const char* const attributeMap, dFloat verticalScale, dFloat horizontalScale_x, dFloat horizontalScale_z, int shapeID);
	NEWTON_API void NewtonHeightFieldSetUserRayCastCallback (const NewtonCollision* const heightfieldCollision, NewtonHeightFieldRayCastCallback rayHitCallback);
	NEWTON_API NewtonCollision* NewtonCreateTreeCollision (const NewtonWorld* const newtonWorld, int shapeID);
	NEWTON_API NewtonCollision* NewtonCreateTreeCollisionFromMesh (const NewtonWorld* const newtonWorld, const NewtonMesh* const mesh, int shapeID);
	NEWTON_API void NewtonTreeCollisionSetUserRayCastCallback (const NewtonCollision* const treeCollision, NewtonCollisionTreeRayCastCallback rayHitCallback);
	NEWTON_API void NewtonTreeCollisionBeginBuild (const NewtonCollision* const treeCollision);
	NEWTON_API void NewtonTreeCollisionAddFace (const NewtonCollision* const treeCollision, int vertexCount, const dFloat* const vertexPtr, int strideInBytes, int faceAttribute);
	NEWTON_API void NewtonTreeCollisionEndBuild (const NewtonCollision* const treeCollision, int optimize);
	NEWTON_API int NewtonTreeCollisionGetFaceAttribute (const NewtonCollision* const treeCollision, const int* const faceIndexArray, int indexCount); 
	NEWTON_API void NewtonTreeCollisionSetFaceAttribute (const NewtonCollision* const treeCollision, const int* const faceIndexArray, int indexCount, int attribute);
	NEWTON_API void NewtonTreeCollisionForEachFace (const NewtonCollision* const treeCollision, NewtonTreeCollisionFaceCallback forEachFaceCallback, void* const context); 
	NEWTON_API int NewtonTreeCollisionGetVertexListTriangleListInAABB (const NewtonCollision* const treeCollision, const dFloat* const p0, const dFloat* const p1, const dFloat** const vertexArray, int* const vertexCount, int* const vertexStrideInBytes, const int* const indexList, int maxIndexCount, const int* const faceAttribute); 
	NEWTON_API void NewtonStaticCollisionSetDebugCallback (const NewtonCollision* const staticCollision, NewtonTreeCollisionCallback userCallback);
	:CATEGORY:23: 
	:CATEGORY:23:  General purpose collision library functions
	:CATEGORY:23: 
	NEWTON_API NewtonCollision* NewtonCollisionCreateInstance (const NewtonCollision* const collision);
	NEWTON_API int NewtonCollisionGetType (const NewtonCollision* const collision);
	NEWTON_API int NewtonCollisionIsConvexShape (const NewtonCollision* const collision);
	NEWTON_API int NewtonCollisionIsStaticShape (const NewtonCollision* const collision);
	NEWTON_API void NewtonCollisionSetUserData (const NewtonCollision* const collision, void* const userData);
	NEWTON_API void* NewtonCollisionGetUserData (const NewtonCollision* const collision);
	NEWTON_API void NewtonCollisionSetUserID (const NewtonCollision* const collision, dLong id);
	NEWTON_API dLong NewtonCollisionGetUserID (const NewtonCollision* const collision);
	NEWTON_API void NewtonCollisionGetMaterial (const NewtonCollision* const collision, NewtonCollisionMaterial* const userData);
	NEWTON_API void NewtonCollisionSetMaterial (const NewtonCollision* const collision, const NewtonCollisionMaterial* const userData);
	NEWTON_API void* NewtonCollisionGetSubCollisionHandle (const NewtonCollision* const collision);
	NEWTON_API NewtonCollision* NewtonCollisionGetParentInstance (const NewtonCollision* const collision);
	NEWTON_API void NewtonCollisionSetMatrix (const NewtonCollision* const collision, const dFloat* const matrix);
	NEWTON_API void NewtonCollisionGetMatrix (const NewtonCollision* const collision, dFloat* const matrix);
	NEWTON_API void NewtonCollisionSetScale (const NewtonCollision* const collision, dFloat scaleX, dFloat scaleY, dFloat scaleZ);
	NEWTON_API void NewtonCollisionGetScale (const NewtonCollision* const collision, dFloat* const scaleX, dFloat* const scaleY, dFloat* const scaleZ);
	NEWTON_API void NewtonDestroyCollision (const NewtonCollision* const collision);
	NEWTON_API dFloat NewtonCollisionGetSkinThickness (const NewtonCollision* const collision);
	NEWTON_API void NewtonCollisionSetSkinThickness(const NewtonCollision* const collision, dFloat thickness);
	NEWTON_API int NewtonCollisionIntersectionTest (const NewtonWorld* const newtonWorld, 
		const NewtonCollision* const collisionA, const dFloat* const matrixA, 
		const NewtonCollision* const collisionB, const dFloat* const matrixB, int threadIndex);
	NEWTON_API int NewtonCollisionPointDistance (const NewtonWorld* const newtonWorld, const dFloat* const point,
		const NewtonCollision* const collision, const dFloat* const matrix, dFloat* const contact, dFloat* const normal, int threadIndex);
	NEWTON_API int NewtonCollisionClosestPoint (const NewtonWorld* const newtonWorld, 
		const NewtonCollision* const collisionA, const dFloat* const matrixA, 
		const NewtonCollision* const collisionB, const dFloat* const matrixB,
		dFloat* const contactA, dFloat* const contactB, dFloat* const normalAB, int threadIndex);
	NEWTON_API int NewtonCollisionCollide (const NewtonWorld* const newtonWorld, int maxSize,
		const NewtonCollision* const collisionA, const dFloat* const matrixA, 
		const NewtonCollision* const collisionB, const dFloat* const matrixB,
		dFloat* const contacts, dFloat* const normals, dFloat* const penetration, 
		dLong* const attributeA, dLong* const attributeB, int threadIndex);
	NEWTON_API int NewtonCollisionCollideContinue (const NewtonWorld* const newtonWorld, int maxSize, dFloat timestep, 
		const NewtonCollision* const collisionA, const dFloat* const matrixA, const dFloat* const velocA, const dFloat* omegaA, 
		const NewtonCollision* const collisionB, const dFloat* const matrixB, const dFloat* const velocB, const dFloat* const omegaB, 
		dFloat* const timeOfImpact, dFloat* const contacts, dFloat* const normals, dFloat* const penetration, 
		dLong* const attributeA, dLong* const attributeB, int threadIndex);
	NEWTON_API void NewtonCollisionSupportVertex (const NewtonCollision* const collision, const dFloat* const dir, dFloat* const vertex);
	NEWTON_API dFloat NewtonCollisionRayCast (const NewtonCollision* const collision, const dFloat* const p0, const dFloat* const p1, dFloat* const normal, dLong* const attribute);
	NEWTON_API void NewtonCollisionCalculateAABB (const NewtonCollision* const collision, const dFloat* const matrix, dFloat* const p0, dFloat* const p1);
	NEWTON_API void NewtonCollisionForEachPolygonDo (const NewtonCollision* const collision, const dFloat* const matrix, NewtonCollisionIterator callback, void* const userData);
	:CATEGORY:25: 
	:CATEGORY:25:  collision aggregates, are a collision node on eh broad phase the serve as the root nod for a collection of rigid bodies
	:CATEGORY:25:  that shared the property of being in close proximity all the time, they are similar to compound collision by the group bodies instead of collision instances
	:CATEGORY:25:  These are good for speeding calculation calculation of rag doll, Vehicles or contractions of rigid bodied lined by joints.
	:CATEGORY:25:  also for example if you know that many the life time of a group of bodies like the object on a house of a building will be localize to the confide of the building
	:CATEGORY:25:  then warping the bodies under an aggregate will reduce collision calculation of almost an order of magnitude.
	:CATEGORY:25: 
	NEWTON_API void* NewtonCollisionAggregateCreate (NewtonWorld* const world); 	
	NEWTON_API void NewtonCollisionAggregateDestroy (void* const aggregate); 	
	NEWTON_API void NewtonCollisionAggregateAddBody (void* const aggregate, const NewtonBody* const body);
	NEWTON_API void NewtonCollisionAggregateRemoveBody (void* const aggregate, const NewtonBody* const body); 	
	NEWTON_API int NewtonCollisionAggregateGetSelfCollision (void* const aggregate);
	NEWTON_API void NewtonCollisionAggregateSetSelfCollision (void* const aggregate, int state);
	:CATEGORY:27: 
	:CATEGORY:27:  transforms utility functions
	:CATEGORY:27: 
	NEWTON_API void NewtonSetEulerAngle (const dFloat* const eulersAngles, dFloat* const matrix);
	NEWTON_API void NewtonGetEulerAngle (const dFloat* const matrix, dFloat* const eulersAngles0, dFloat* const eulersAngles1);
	NEWTON_API dFloat NewtonCalculateSpringDamperAcceleration (dFloat dt, dFloat ks, dFloat x, dFloat kd, dFloat s);
	:CATEGORY:29: 
	:CATEGORY:29:  body manipulation functions
	:CATEGORY:29: 
	NEWTON_API NewtonBody* NewtonCreateDynamicBody (const NewtonWorld* const newtonWorld, const NewtonCollision* const collision, const dFloat* const matrix);
	NEWTON_API NewtonBody* NewtonCreateKinematicBody (const NewtonWorld* const newtonWorld, const NewtonCollision* const collision, const dFloat* const matrix);
	NEWTON_API NewtonBody* NewtonCreateAsymetricDynamicBody(const NewtonWorld* const newtonWorld, const NewtonCollision* const collision, const dFloat* const matrix);
	NEWTON_API void NewtonDestroyBody(const NewtonBody* const body);
	NEWTON_API int NewtonBodyGetSimulationState(const NewtonBody* const body);
	NEWTON_API void NewtonBodySetSimulationState(const NewtonBody* const bodyPtr, const int state);
	NEWTON_API int NewtonBodyGetType (const NewtonBody* const body);
	NEWTON_API int NewtonBodyGetCollidable (const NewtonBody* const body);
	NEWTON_API void NewtonBodySetCollidable (const NewtonBody* const body, int collidableState);
	NEWTON_API void  NewtonBodyAddForce (const NewtonBody* const body, const dFloat* const force);
	NEWTON_API void  NewtonBodyAddTorque (const NewtonBody* const body, const dFloat* const torque);
	NEWTON_API void  NewtonBodySetCentreOfMass (const NewtonBody* const body, const dFloat* const com);
	NEWTON_API void  NewtonBodySetMassMatrix (const NewtonBody* const body, dFloat mass, dFloat Ixx, dFloat Iyy, dFloat Izz);
	NEWTON_API void  NewtonBodySetFullMassMatrix (const NewtonBody* const body, dFloat mass, const dFloat* const inertiaMatrix);
	NEWTON_API void  NewtonBodySetMassProperties (const NewtonBody* const body, dFloat mass, const NewtonCollision* const collision);
	NEWTON_API void  NewtonBodySetMatrix (const NewtonBody* const body, const dFloat* const matrix);
	NEWTON_API void  NewtonBodySetMatrixNoSleep (const NewtonBody* const body, const dFloat* const matrix);
	NEWTON_API void  NewtonBodySetMatrixRecursive (const NewtonBody* const body, const dFloat* const matrix);
	NEWTON_API void  NewtonBodySetMaterialGroupID (const NewtonBody* const body, int id);
	NEWTON_API void  NewtonBodySetContinuousCollisionMode (const NewtonBody* const body, unsigned state);
	NEWTON_API void  NewtonBodySetJointRecursiveCollision (const NewtonBody* const body, unsigned state);
	NEWTON_API void  NewtonBodySetOmega (const NewtonBody* const body, const dFloat* const omega);
	NEWTON_API void  NewtonBodySetOmegaNoSleep (const NewtonBody* const body, const dFloat* const omega);
	NEWTON_API void  NewtonBodySetVelocity (const NewtonBody* const body, const dFloat* const velocity);
	NEWTON_API void  NewtonBodySetVelocityNoSleep (const NewtonBody* const body, const dFloat* const velocity);
	NEWTON_API void  NewtonBodySetForce (const NewtonBody* const body, const dFloat* const force);
	NEWTON_API void  NewtonBodySetTorque (const NewtonBody* const body, const dFloat* const torque);
	NEWTON_API void  NewtonBodySetLinearDamping (const NewtonBody* const body, dFloat linearDamp);
	NEWTON_API void  NewtonBodySetAngularDamping (const NewtonBody* const body, const dFloat* const angularDamp);
	NEWTON_API void  NewtonBodySetCollision (const NewtonBody* const body, const NewtonCollision* const collision);
	NEWTON_API void  NewtonBodySetCollisionScale (const NewtonBody* const body, dFloat scaleX, dFloat  scaleY, dFloat scaleZ);
	NEWTON_API int  NewtonBodyGetSleepState (const NewtonBody* const body);
	NEWTON_API void NewtonBodySetSleepState (const NewtonBody* const body, int state);
	NEWTON_API int  NewtonBodyGetAutoSleep (const NewtonBody* const body);
	NEWTON_API void NewtonBodySetAutoSleep (const NewtonBody* const body, int state);
	NEWTON_API int  NewtonBodyGetFreezeState(const NewtonBody* const body);
	NEWTON_API void NewtonBodySetFreezeState (const NewtonBody* const body, int state);
	NEWTON_API int NewtonBodyGetGyroscopicTorque(const NewtonBody* const body);
	NEWTON_API void NewtonBodySetGyroscopicTorque(const NewtonBody* const body, int state);
	NEWTON_API void NewtonBodySetDestructorCallback (const NewtonBody* const body, NewtonBodyDestructor callback);
	NEWTON_API NewtonBodyDestructor NewtonBodyGetDestructorCallback (const NewtonBody* const body);
	NEWTON_API void  NewtonBodySetTransformCallback (const NewtonBody* const body, NewtonSetTransform callback);
	NEWTON_API NewtonSetTransform NewtonBodyGetTransformCallback (const NewtonBody* const body);
	NEWTON_API void  NewtonBodySetForceAndTorqueCallback (const NewtonBody* const body, NewtonApplyForceAndTorque callback);
	NEWTON_API NewtonApplyForceAndTorque NewtonBodyGetForceAndTorqueCallback (const NewtonBody* const body);
	NEWTON_API int NewtonBodyGetID (const NewtonBody* const body);
	NEWTON_API void  NewtonBodySetUserData (const NewtonBody* const body, void* const userData);
	NEWTON_API void* NewtonBodyGetUserData (const NewtonBody* const body);
	NEWTON_API NewtonWorld* NewtonBodyGetWorld (const NewtonBody* const body);
	NEWTON_API NewtonCollision* NewtonBodyGetCollision (const NewtonBody* const body);
	NEWTON_API int NewtonBodyGetMaterialGroupID (const NewtonBody* const body);
	NEWTON_API int NewtonBodyGetSerializedID(const NewtonBody* const body);
	NEWTON_API int NewtonBodyGetContinuousCollisionMode (const NewtonBody* const body);
	NEWTON_API int NewtonBodyGetJointRecursiveCollision (const NewtonBody* const body);
	NEWTON_API void NewtonBodyGetPosition(const NewtonBody* const body, dFloat* const pos);
	NEWTON_API void NewtonBodyGetMatrix(const NewtonBody* const body, dFloat* const matrix);
	NEWTON_API void NewtonBodyGetRotation(const NewtonBody* const body, dFloat* const rotation);
	NEWTON_API void NewtonBodyGetMass (const NewtonBody* const body, dFloat* mass, dFloat* const Ixx, dFloat* const Iyy, dFloat* const Izz);
	NEWTON_API void NewtonBodyGetInvMass(const NewtonBody* const body, dFloat* const invMass, dFloat* const invIxx, dFloat* const invIyy, dFloat* const invIzz);
	NEWTON_API void NewtonBodyGetInertiaMatrix(const NewtonBody* const body, dFloat* const inertiaMatrix);
	NEWTON_API void NewtonBodyGetInvInertiaMatrix(const NewtonBody* const body, dFloat* const invInertiaMatrix);
	NEWTON_API void NewtonBodyGetOmega(const NewtonBody* const body, dFloat* const vector);
	NEWTON_API void NewtonBodyGetVelocity(const NewtonBody* const body, dFloat* const vector);
	NEWTON_API void NewtonBodyGetAlpha(const NewtonBody* const body, dFloat* const vector);
	NEWTON_API void NewtonBodyGetAcceleration(const NewtonBody* const body, dFloat* const vector);
	NEWTON_API void NewtonBodyGetForce(const NewtonBody* const body, dFloat* const vector);
	NEWTON_API void NewtonBodyGetTorque(const NewtonBody* const body, dFloat* const vector);
	NEWTON_API void NewtonBodyGetCentreOfMass (const NewtonBody* const body, dFloat* const com);
	NEWTON_API void NewtonBodyGetPointVelocity (const NewtonBody* const body, const dFloat* const point, dFloat* const velocOut);
	NEWTON_API void NewtonBodyApplyImpulsePair (const NewtonBody* const body, dFloat* const linearImpulse, dFloat* const angularImpulse, dFloat timestep);
	NEWTON_API void NewtonBodyAddImpulse (const NewtonBody* const body, const dFloat* const pointDeltaVeloc, const dFloat* const pointPosit, dFloat timestep);
	NEWTON_API void NewtonBodyApplyImpulseArray (const NewtonBody* const body, int impuleCount, int strideInByte, const dFloat* const impulseArray, const dFloat* const pointArray, dFloat timestep);
	NEWTON_API void NewtonBodyIntegrateVelocity (const NewtonBody* const body, dFloat timestep);
	NEWTON_API dFloat NewtonBodyGetLinearDamping (const NewtonBody* const body);
	NEWTON_API void  NewtonBodyGetAngularDamping (const NewtonBody* const body, dFloat* const vector);
	NEWTON_API void  NewtonBodyGetAABB (const NewtonBody* const body, dFloat* const p0, dFloat* const p1);
	NEWTON_API NewtonJoint* NewtonBodyGetFirstJoint (const NewtonBody* const body);
	NEWTON_API NewtonJoint* NewtonBodyGetNextJoint (const NewtonBody* const body, const NewtonJoint* const joint);
	NEWTON_API NewtonJoint* NewtonBodyGetFirstContactJoint (const NewtonBody* const body);
	NEWTON_API NewtonJoint* NewtonBodyGetNextContactJoint (const NewtonBody* const body, const NewtonJoint* const contactJoint);
	NEWTON_API NewtonJoint* NewtonBodyFindContact (const NewtonBody* const body0, const NewtonBody* const body1);
	:CATEGORY:31: 
	:CATEGORY:31:  contact joints interface
	:CATEGORY:31: 
	NEWTON_API void* NewtonContactJointGetFirstContact (const NewtonJoint* const contactJoint);
	NEWTON_API void* NewtonContactJointGetNextContact (const NewtonJoint* const contactJoint, void* const contact);
	NEWTON_API int NewtonContactJointGetContactCount(const NewtonJoint* const contactJoint);
	NEWTON_API void NewtonContactJointRemoveContact(const NewtonJoint* const contactJoint, void* const contact); 
	NEWTON_API dFloat NewtonContactJointGetClosestDistance(const NewtonJoint* const contactJoint);
	NEWTON_API void NewtonContactJointResetSelftJointCollision(const NewtonJoint* const contactJoint);
	NEWTON_API void NewtonContactJointResetIntraJointCollision(const NewtonJoint* const contactJoint);
	NEWTON_API NewtonMaterial* NewtonContactGetMaterial (const void* const contact);
	NEWTON_API NewtonCollision* NewtonContactGetCollision0 (const void* const contact);	
	NEWTON_API NewtonCollision* NewtonContactGetCollision1 (const void* const contact);	
	NEWTON_API void* NewtonContactGetCollisionID0 (const void* const contact);	
	NEWTON_API void* NewtonContactGetCollisionID1 (const void* const contact);	
	:CATEGORY:33: 
	:CATEGORY:33:  Common joint functions
	:CATEGORY:33: 
	NEWTON_API void* NewtonJointGetUserData (const NewtonJoint* const joint);
	NEWTON_API void NewtonJointSetUserData (const NewtonJoint* const joint, void* const userData);
	NEWTON_API NewtonBody* NewtonJointGetBody0 (const NewtonJoint* const joint);
	NEWTON_API NewtonBody* NewtonJointGetBody1 (const NewtonJoint* const joint);
	NEWTON_API void NewtonJointGetInfo  (const NewtonJoint* const joint, NewtonJointRecord* const info);
	NEWTON_API int NewtonJointGetCollisionState (const NewtonJoint* const joint);
	NEWTON_API void NewtonJointSetCollisionState (const NewtonJoint* const joint, int state);
	NEWTON_API dFloat NewtonJointGetStiffness (const NewtonJoint* const joint);
	NEWTON_API void NewtonJointSetStiffness (const NewtonJoint* const joint, dFloat state);
	NEWTON_API void NewtonDestroyJoint(const NewtonWorld* const newtonWorld, const NewtonJoint* const joint);
	NEWTON_API void NewtonJointSetDestructor (const NewtonJoint* const joint, NewtonConstraintDestructor destructor);
	NEWTON_API int NewtonJointIsActive (const NewtonJoint* const joint);
	:CATEGORY:35: 
	:CATEGORY:35:  particle system interface (soft bodies, individual, pressure bodies and cloth)
	:CATEGORY:35: 
	NEWTON_API NewtonCollision* NewtonCreateMassSpringDamperSystem (const NewtonWorld* const newtonWorld, int shapeID,
																	const dFloat* const points, int pointCount, int strideInBytes, const dFloat* const pointMass, 
																	const int* const links, int linksCount, const dFloat* const linksSpring, const dFloat* const linksDamper);
	NEWTON_API NewtonCollision* NewtonCreateDeformableSolid(const NewtonWorld* const newtonWorld, const NewtonMesh* const mesh, int shapeID);
	NEWTON_API int NewtonDeformableMeshGetParticleCount (const NewtonCollision* const deformableMesh); 
	NEWTON_API int NewtonDeformableMeshGetParticleStrideInBytes (const NewtonCollision* const deformableMesh); 
	NEWTON_API const dFloat* NewtonDeformableMeshGetParticleArray (const NewtonCollision* const deformableMesh); 
	:CATEGORY:37: 
	:CATEGORY:37:  Ball and Socket joint functions
	:CATEGORY:37: 
	NEWTON_API NewtonJoint* NewtonConstraintCreateBall (const NewtonWorld* const newtonWorld, const dFloat* pivotPoint, const NewtonBody* const childBody, const NewtonBody* const parentBody);
	NEWTON_API void NewtonBallSetUserCallback (const NewtonJoint* const ball, NewtonBallCallback callback);
	NEWTON_API void NewtonBallGetJointAngle (const NewtonJoint* const ball, dFloat* angle);
	NEWTON_API void NewtonBallGetJointOmega (const NewtonJoint* const ball, dFloat* omega);
	NEWTON_API void NewtonBallGetJointForce (const NewtonJoint* const ball, dFloat* const force);
	NEWTON_API void NewtonBallSetConeLimits (const NewtonJoint* const ball, const dFloat* pin, dFloat maxConeAngle, dFloat maxTwistAngle);
	:CATEGORY:39: 
	:CATEGORY:39:  Hinge joint functions
	:CATEGORY:39: 
	NEWTON_API NewtonJoint* NewtonConstraintCreateHinge (const NewtonWorld* const newtonWorld, const dFloat* pivotPoint, const dFloat* pinDir, const NewtonBody* const childBody, const NewtonBody* const parentBody);
	NEWTON_API void NewtonHingeSetUserCallback (const NewtonJoint* const hinge, NewtonHingeCallback callback);
	NEWTON_API dFloat NewtonHingeGetJointAngle (const NewtonJoint* const hinge);
	NEWTON_API dFloat NewtonHingeGetJointOmega (const NewtonJoint* const hinge);
	NEWTON_API void NewtonHingeGetJointForce (const NewtonJoint* const hinge, dFloat* const force);
	NEWTON_API dFloat NewtonHingeCalculateStopAlpha (const NewtonJoint* const hinge, const NewtonHingeSliderUpdateDesc* const desc, dFloat angle);
	:CATEGORY:41: 
	:CATEGORY:41:  Slider joint functions
	:CATEGORY:41: 
	NEWTON_API NewtonJoint* NewtonConstraintCreateSlider (const NewtonWorld* const newtonWorld, const dFloat* pivotPoint, const dFloat* pinDir, const NewtonBody* const childBody, const NewtonBody* const parentBody);
	NEWTON_API void NewtonSliderSetUserCallback (const NewtonJoint* const slider, NewtonSliderCallback callback);
	NEWTON_API dFloat NewtonSliderGetJointPosit (const NewtonJoint* slider);
	NEWTON_API dFloat NewtonSliderGetJointVeloc (const NewtonJoint* slider);
	NEWTON_API void NewtonSliderGetJointForce (const NewtonJoint* const slider, dFloat* const force);
	NEWTON_API dFloat NewtonSliderCalculateStopAccel (const NewtonJoint* const slider, const NewtonHingeSliderUpdateDesc* const desc, dFloat position);
	:CATEGORY:43: 
	:CATEGORY:43:  Corkscrew joint functions
	:CATEGORY:43: 
	NEWTON_API NewtonJoint* NewtonConstraintCreateCorkscrew (const NewtonWorld* const newtonWorld, const dFloat* pivotPoint, const dFloat* pinDir, const NewtonBody* const childBody, const NewtonBody* const parentBody);
	NEWTON_API void NewtonCorkscrewSetUserCallback (const NewtonJoint* const corkscrew, NewtonCorkscrewCallback callback);
	NEWTON_API dFloat NewtonCorkscrewGetJointPosit (const NewtonJoint* const corkscrew);
	NEWTON_API dFloat NewtonCorkscrewGetJointAngle (const NewtonJoint* const corkscrew);
	NEWTON_API dFloat NewtonCorkscrewGetJointVeloc (const NewtonJoint* const corkscrew);
	NEWTON_API dFloat NewtonCorkscrewGetJointOmega (const NewtonJoint* const corkscrew);
	NEWTON_API void NewtonCorkscrewGetJointForce (const NewtonJoint* const corkscrew, dFloat* const force);
	NEWTON_API dFloat NewtonCorkscrewCalculateStopAlpha (const NewtonJoint* const corkscrew, const NewtonHingeSliderUpdateDesc* const desc, dFloat angle);
	NEWTON_API dFloat NewtonCorkscrewCalculateStopAccel (const NewtonJoint* const corkscrew, const NewtonHingeSliderUpdateDesc* const desc, dFloat position);
	:CATEGORY:45: 
	:CATEGORY:45:  Universal joint functions
	:CATEGORY:45: 
	NEWTON_API NewtonJoint* NewtonConstraintCreateUniversal (const NewtonWorld* const newtonWorld, const dFloat* pivotPoint, const dFloat* pinDir0, const dFloat* pinDir1, const NewtonBody* const childBody, const NewtonBody* const parentBody);
	NEWTON_API void NewtonUniversalSetUserCallback (const NewtonJoint* const universal, NewtonUniversalCallback callback);
	NEWTON_API dFloat NewtonUniversalGetJointAngle0 (const NewtonJoint* const universal);
	NEWTON_API dFloat NewtonUniversalGetJointAngle1 (const NewtonJoint* const universal);
	NEWTON_API dFloat NewtonUniversalGetJointOmega0 (const NewtonJoint* const universal);
	NEWTON_API dFloat NewtonUniversalGetJointOmega1 (const NewtonJoint* const universal);
	NEWTON_API void NewtonUniversalGetJointForce (const NewtonJoint* const universal, dFloat* const force);
	NEWTON_API dFloat NewtonUniversalCalculateStopAlpha0 (const NewtonJoint* const universal, const NewtonHingeSliderUpdateDesc* const desc, dFloat angle);
	NEWTON_API dFloat NewtonUniversalCalculateStopAlpha1 (const NewtonJoint* const universal, const NewtonHingeSliderUpdateDesc* const desc, dFloat angle);
	:CATEGORY:47: 
	:CATEGORY:47:  Up vector joint functions
	:CATEGORY:47: 
	NEWTON_API NewtonJoint* NewtonConstraintCreateUpVector (const NewtonWorld* const newtonWorld, const dFloat* pinDir, const NewtonBody* const body); 
	NEWTON_API void NewtonUpVectorGetPin (const NewtonJoint* const upVector, dFloat *pin);
	NEWTON_API void NewtonUpVectorSetPin (const NewtonJoint* const upVector, const dFloat *pin);
	:CATEGORY:49: 
	:CATEGORY:49:  User defined bilateral Joint
	:CATEGORY:49: 
	NEWTON_API NewtonJoint* NewtonConstraintCreateUserJoint (const NewtonWorld* const newtonWorld, int maxDOF, NewtonUserBilateralCallback callback, const NewtonBody* const childBody, const NewtonBody* const parentBody) ; 
	NEWTON_API int NewtonUserJointGetSolverModel(const NewtonJoint* const joint);
	NEWTON_API void NewtonUserJointSetSolverModel(const NewtonJoint* const joint, int model);
	NEWTON_API void NewtonUserJointMassScale(const NewtonJoint* const joint, dFloat scaleBody0, dFloat scaleBody1);
	NEWTON_API void NewtonUserJointSetFeedbackCollectorCallback (const NewtonJoint* const joint, NewtonUserBilateralCallback getFeedback);
	NEWTON_API void NewtonUserJointAddLinearRow (const NewtonJoint* const joint, const dFloat* const pivot0, const dFloat* const pivot1, const dFloat* const dir);
	NEWTON_API void NewtonUserJointAddAngularRow (const NewtonJoint* const joint, dFloat relativeAngle, const dFloat* const dir);
	NEWTON_API void NewtonUserJointAddGeneralRow (const NewtonJoint* const joint, const dFloat* const jacobian0, const dFloat* const jacobian1);
	NEWTON_API void NewtonUserJointSetRowMinimumFriction (const NewtonJoint* const joint, dFloat friction);
	NEWTON_API void NewtonUserJointSetRowMaximumFriction (const NewtonJoint* const joint, dFloat friction);
	NEWTON_API dFloat NewtonUserJointCalculateRowZeroAcceleration (const NewtonJoint* const joint);
	NEWTON_API dFloat NewtonUserJointGetRowAcceleration (const NewtonJoint* const joint);
	NEWTON_API void NewtonUserJointGetRowJacobian(const NewtonJoint* const joint, dFloat* const linear0, dFloat* const angula0, dFloat* const linear1, dFloat* const angula1);
	NEWTON_API void NewtonUserJointSetRowAcceleration (const NewtonJoint* const joint, dFloat acceleration);
	NEWTON_API void NewtonUserJointSetRowSpringDamperAcceleration (const NewtonJoint* const joint, dFloat rowStiffness, dFloat spring, dFloat damper);
	NEWTON_API void NewtonUserJointSetRowStiffness (const NewtonJoint* const joint, dFloat stiffness);
	NEWTON_API int NewtonUserJoinRowsCount (const NewtonJoint* const joint);
	NEWTON_API void NewtonUserJointGetGeneralRow (const NewtonJoint* const joint, int index, dFloat* const jacobian0, dFloat* const jacobian1);
	NEWTON_API dFloat NewtonUserJointGetRowForce (const NewtonJoint* const joint, int row);
	:CATEGORY:51: 
	:CATEGORY:51:  Mesh joint functions
	:CATEGORY:51: 
	NEWTON_API NewtonMesh* NewtonMeshCreate(const NewtonWorld* const newtonWorld);
	NEWTON_API NewtonMesh* NewtonMeshCreateFromMesh(const NewtonMesh* const mesh);
	NEWTON_API NewtonMesh* NewtonMeshCreateFromCollision(const NewtonCollision* const collision);
	NEWTON_API NewtonMesh* NewtonMeshCreateTetrahedraIsoSurface(const NewtonMesh* const mesh);
	NEWTON_API NewtonMesh* NewtonMeshCreateConvexHull (const NewtonWorld* const newtonWorld, int pointCount, const dFloat* const vertexCloud, int strideInBytes, dFloat tolerance);
	NEWTON_API NewtonMesh* NewtonMeshCreateVoronoiConvexDecomposition (const NewtonWorld* const newtonWorld, int pointCount, const dFloat* const vertexCloud, int strideInBytes, int materialID, const dFloat* const textureMatrix);
	NEWTON_API NewtonMesh* NewtonMeshCreateFromSerialization (const NewtonWorld* const newtonWorld, NewtonDeserializeCallback deserializeFunction, void* const serializeHandle);
	NEWTON_API void NewtonMeshDestroy(const NewtonMesh* const mesh);
	NEWTON_API void NewtonMeshSerialize (const NewtonMesh* const mesh, NewtonSerializeCallback serializeFunction, void* const serializeHandle);
	NEWTON_API void NewtonMeshSaveOFF(const NewtonMesh* const mesh, const char* const filename);
	NEWTON_API NewtonMesh* NewtonMeshLoadOFF(const NewtonWorld* const newtonWorld, const char* const filename);
	NEWTON_API NewtonMesh* NewtonMeshLoadTetrahedraMesh(const NewtonWorld* const newtonWorld, const char* const filename);
	NEWTON_API void NewtonMeshFlipWinding(const NewtonMesh* const mesh);
	NEWTON_API void NewtonMeshApplyTransform (const NewtonMesh* const mesh, const dFloat* const matrix);
	NEWTON_API void NewtonMeshCalculateOOBB(const NewtonMesh* const mesh, dFloat* const matrix, dFloat* const x, dFloat* const y, dFloat* const z);
	NEWTON_API void NewtonMeshCalculateVertexNormals(const NewtonMesh* const mesh, dFloat angleInRadians);
	NEWTON_API void NewtonMeshApplySphericalMapping(const NewtonMesh* const mesh, int material, const dFloat* const aligmentMatrix);
	NEWTON_API void NewtonMeshApplyCylindricalMapping(const NewtonMesh* const mesh, int cylinderMaterial, int capMaterial, const dFloat* const aligmentMatrix);
	NEWTON_API void NewtonMeshApplyBoxMapping(const NewtonMesh* const mesh, int frontMaterial, int sideMaterial, int topMaterial, const dFloat* const aligmentMatrix);
	NEWTON_API void NewtonMeshApplyAngleBasedMapping(const NewtonMesh* const mesh, int material, NewtonReportProgress reportPrograssCallback, void* const reportPrgressUserData, dFloat* const aligmentMatrix);
	NEWTON_API void NewtonCreateTetrahedraLinearBlendSkinWeightsChannel(const NewtonMesh* const tetrahedraMesh, NewtonMesh* const skinMesh);
	NEWTON_API void NewtonMeshOptimize (const NewtonMesh* const mesh);
	NEWTON_API void NewtonMeshOptimizePoints (const NewtonMesh* const mesh);
	NEWTON_API void NewtonMeshOptimizeVertex (const NewtonMesh* const mesh);
	NEWTON_API int NewtonMeshIsOpenMesh (const NewtonMesh* const mesh);
	NEWTON_API void NewtonMeshFixTJoints (const NewtonMesh* const mesh);
	NEWTON_API void NewtonMeshPolygonize (const NewtonMesh* const mesh);
	NEWTON_API void NewtonMeshTriangulate (const NewtonMesh* const mesh);
	NEWTON_API NewtonMesh* NewtonMeshUnion (const NewtonMesh* const mesh, const NewtonMesh* const clipper, const dFloat* const clipperMatrix);
	NEWTON_API NewtonMesh* NewtonMeshDifference (const NewtonMesh* const mesh, const NewtonMesh* const clipper, const dFloat* const clipperMatrix);
	NEWTON_API NewtonMesh* NewtonMeshIntersection (const NewtonMesh* const mesh, const NewtonMesh* const clipper, const dFloat* const clipperMatrix);
	NEWTON_API void NewtonMeshClip (const NewtonMesh* const mesh, const NewtonMesh* const clipper, const dFloat* const clipperMatrix, NewtonMesh** const topMesh, NewtonMesh** const bottomMesh);
	NEWTON_API NewtonMesh* NewtonMeshConvexMeshIntersection (const NewtonMesh* const mesh, const NewtonMesh* const convexMesh);
	NEWTON_API NewtonMesh* NewtonMeshSimplify (const NewtonMesh* const mesh, int maxVertexCount, NewtonReportProgress reportPrograssCallback, void* const reportPrgressUserData);
	NEWTON_API NewtonMesh* NewtonMeshApproximateConvexDecomposition (const NewtonMesh* const mesh, dFloat maxConcavity, dFloat backFaceDistanceFactor, int maxCount, int maxVertexPerHull, NewtonReportProgress reportProgressCallback, void* const reportProgressUserData);
	NEWTON_API void NewtonRemoveUnusedVertices(const NewtonMesh* const mesh, int* const vertexRemapTable);
	NEWTON_API void NewtonMeshBeginBuild(const NewtonMesh* const mesh);
		NEWTON_API void NewtonMeshBeginFace(const NewtonMesh* const mesh);
			NEWTON_API void NewtonMeshAddPoint(const NewtonMesh* const mesh, dFloat64 x, dFloat64 y, dFloat64 z);
			NEWTON_API void NewtonMeshAddLayer(const NewtonMesh* const mesh, int layerIndex);
			NEWTON_API void NewtonMeshAddMaterial(const NewtonMesh* const mesh, int materialIndex);
			NEWTON_API void NewtonMeshAddNormal(const NewtonMesh* const mesh, dFloat x, dFloat y, dFloat z);
			NEWTON_API void NewtonMeshAddBinormal(const NewtonMesh* const mesh, dFloat x, dFloat y, dFloat z);
			NEWTON_API void NewtonMeshAddUV0(const NewtonMesh* const mesh, dFloat u, dFloat v);
			NEWTON_API void NewtonMeshAddUV1(const NewtonMesh* const mesh, dFloat u, dFloat v);
			NEWTON_API void NewtonMeshAddVertexColor(const NewtonMesh* const mesh, dFloat32 r, dFloat32 g, dFloat32 b, dFloat32 a);
		NEWTON_API void NewtonMeshEndFace(const NewtonMesh* const mesh);
	NEWTON_API void NewtonMeshEndBuild(const NewtonMesh* const mesh);
	NEWTON_API void NewtonMeshClearVertexFormat (NewtonMeshVertexFormat* const format);
	NEWTON_API void NewtonMeshBuildFromVertexListIndexList (const NewtonMesh* const mesh, const NewtonMeshVertexFormat* const format);
	NEWTON_API int NewtonMeshGetPointCount (const NewtonMesh* const mesh); 
	NEWTON_API const int* NewtonMeshGetIndexToVertexMap(const NewtonMesh* const mesh);
	NEWTON_API void NewtonMeshGetVertexDoubleChannel (const NewtonMesh* const mesh, int vertexStrideInByte, dFloat64* const outBuffer);
	NEWTON_API void NewtonMeshGetVertexChannel (const NewtonMesh* const mesh, int vertexStrideInByte, dFloat* const outBuffer);
	NEWTON_API void NewtonMeshGetNormalChannel (const NewtonMesh* const mesh, int vertexStrideInByte, dFloat* const outBuffer);
	NEWTON_API void NewtonMeshGetBinormalChannel (const NewtonMesh* const mesh, int vertexStrideInByte, dFloat* const outBuffer);
	NEWTON_API void NewtonMeshGetUV0Channel (const NewtonMesh* const mesh, int vertexStrideInByte, dFloat* const outBuffer);
	NEWTON_API void NewtonMeshGetUV1Channel (const NewtonMesh* const mesh, int vertexStrideInByte, dFloat* const outBuffer);
	NEWTON_API void NewtonMeshGetVertexColorChannel (const NewtonMesh* const mesh, int vertexStrideInByte, dFloat* const outBuffer);
	NEWTON_API int NewtonMeshHasNormalChannel(const NewtonMesh* const mesh);
	NEWTON_API int NewtonMeshHasBinormalChannel(const NewtonMesh* const mesh);
	NEWTON_API int NewtonMeshHasUV0Channel(const NewtonMesh* const mesh);
	NEWTON_API int NewtonMeshHasUV1Channel(const NewtonMesh* const mesh);
	NEWTON_API int NewtonMeshHasVertexColorChannel(const NewtonMesh* const mesh);
	NEWTON_API void* NewtonMeshBeginHandle (const NewtonMesh* const mesh); 
	NEWTON_API void NewtonMeshEndHandle (const NewtonMesh* const mesh, void* const handle); 
	NEWTON_API int NewtonMeshFirstMaterial (const NewtonMesh* const mesh, void* const handle); 
	NEWTON_API int NewtonMeshNextMaterial (const NewtonMesh* const mesh, void* const handle, int materialId); 
	NEWTON_API int NewtonMeshMaterialGetMaterial (const NewtonMesh* const mesh, void* const handle, int materialId); 
	NEWTON_API int NewtonMeshMaterialGetIndexCount (const NewtonMesh* const mesh, void* const handle, int materialId); 
	NEWTON_API void NewtonMeshMaterialGetIndexStream (const NewtonMesh* const mesh, void* const handle, int materialId, int* const index); 
	NEWTON_API void NewtonMeshMaterialGetIndexStreamShort (const NewtonMesh* const mesh, void* const handle, int materialId, short int* const index); 
	NEWTON_API NewtonMesh* NewtonMeshCreateFirstSingleSegment (const NewtonMesh* const mesh); 
	NEWTON_API NewtonMesh* NewtonMeshCreateNextSingleSegment (const NewtonMesh* const mesh, const NewtonMesh* const segment); 
	NEWTON_API NewtonMesh* NewtonMeshCreateFirstLayer (const NewtonMesh* const mesh); 
	NEWTON_API NewtonMesh* NewtonMeshCreateNextLayer (const NewtonMesh* const mesh, const NewtonMesh* const segment); 
	NEWTON_API int NewtonMeshGetTotalFaceCount (const NewtonMesh* const mesh); 
	NEWTON_API int NewtonMeshGetTotalIndexCount (const NewtonMesh* const mesh); 
	NEWTON_API void NewtonMeshGetFaces (const NewtonMesh* const mesh, int* const faceIndexCount, int* const faceMaterial, void** const faceIndices); 
	NEWTON_API int NewtonMeshGetVertexCount (const NewtonMesh* const mesh); 
	NEWTON_API int NewtonMeshGetVertexStrideInByte (const NewtonMesh* const mesh); 
	NEWTON_API const dFloat64* NewtonMeshGetVertexArray (const NewtonMesh* const mesh); 
	NEWTON_API int NewtonMeshGetVertexBaseCount(const NewtonMesh* const mesh);
	NEWTON_API void NewtonMeshSetVertexBaseCount(const NewtonMesh* const mesh, int baseCount);
	NEWTON_API void* NewtonMeshGetFirstVertex (const NewtonMesh* const mesh);
	NEWTON_API void* NewtonMeshGetNextVertex (const NewtonMesh* const mesh, const void* const vertex);
	NEWTON_API int NewtonMeshGetVertexIndex (const NewtonMesh* const mesh, const void* const vertex);
	NEWTON_API void* NewtonMeshGetFirstPoint (const NewtonMesh* const mesh);
	NEWTON_API void* NewtonMeshGetNextPoint (const NewtonMesh* const mesh, const void* const point);
	NEWTON_API int NewtonMeshGetPointIndex (const NewtonMesh* const mesh, const void* const point);
	NEWTON_API int NewtonMeshGetVertexIndexFromPoint (const NewtonMesh* const mesh, const void* const point);
	NEWTON_API void* NewtonMeshGetFirstEdge (const NewtonMesh* const mesh);
	NEWTON_API void* NewtonMeshGetNextEdge (const NewtonMesh* const mesh, const void* const edge);
	NEWTON_API void NewtonMeshGetEdgeIndices (const NewtonMesh* const mesh, const void* const edge, int* const v0, int* const v1);
	NEWTON_API void* NewtonMeshGetFirstFace (const NewtonMesh* const mesh);
	NEWTON_API void* NewtonMeshGetNextFace (const NewtonMesh* const mesh, const void* const face);
	NEWTON_API int NewtonMeshIsFaceOpen (const NewtonMesh* const mesh, const void* const face);
	NEWTON_API int NewtonMeshGetFaceMaterial (const NewtonMesh* const mesh, const void* const face);
	NEWTON_API int NewtonMeshGetFaceIndexCount (const NewtonMesh* const mesh, const void* const face);
	NEWTON_API void NewtonMeshGetFaceIndices (const NewtonMesh* const mesh, const void* const face, int* const indices);
	NEWTON_API void NewtonMeshGetFacePointIndices (const NewtonMesh* const mesh, const void* const face, int* const indices);
	NEWTON_API void NewtonMeshCalculateFaceNormal (const NewtonMesh* const mesh, const void* const face, dFloat64* const normal);
	NEWTON_API void NewtonMeshSetFaceMaterial (const NewtonMesh* const mesh, const void* const face, int matId);
#ifdef __cplusplus 
}
#endif
#endif
