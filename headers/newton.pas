(* Copyright (c) <2003-2019> <Julio Jerez, Newton Game Dynamics>
*
* This software is provided 'as-is', without any express or implied
* warranty. In no event will the authors be held liable for any damages
* arising from the use of this software.
*
* Permission is granted to anyone to use this software for any purpose,
* including commercial applications, and to alter it and redistribute it
* freely, subject to the following restrictions:
*
* 1. The origin of this software must not be misrepresented; you must not
* claim that you wrote the original software. If you use this software
* in a product, an acknowledgment in the product documentation would be
* appreciated but is not required.
*
* 2. Altered source versions must be plainly marked as such, and must not be
* misrepresented as being the original software.
*
* 3. This notice may not be removed or altered from any source distribution.
*)

{ ********************************************************************** }
{ Automated Newton Pascal Header translation                             }
{ Copyright 2005-2019 Jernej L.                                          }
{ Type names are based on original work by S.Spasov(Sury)                }
{ ********************************************************************** }

// Define double to use newton in double precision

{$undef double}
{$i compiler.inc}

unit Newton;

interface

const
  newtondll = 'Newton.dll';

type

{$ifndef double}
	float = Single;
	dfloat = Single;
{$else}
	float = Double;
	dfloat = Double;
{$endif}
	Pfloat = ^float;
	Pdfloat = ^dfloat;

	Pinteger = ^integer;
	Psmallint = ^smallint;
	PPointer = ^Pointer;

{ Newton objects }
	PNewtonMesh = ^Pointer;
	PNewtonBody = ^Pointer;
	PNewtonWorld = ^Pointer;
	PNewtonJoint = ^Pointer;
	PNewtonMaterial = ^Pointer;
	PNewtonCollision = ^Pointer;
	PNewtonSceneProxy = ^Pointer;
	PNewtonFracturedCompoundMeshPart = ^Pointer;
	PNewtonDeformableMeshSegment = ^Pointer;
	PNewtonAcyclicArticulation = ^Pointer;
	PNewtonInverseDynamics = ^Pointer;

	TNewtonFuncLinkRecord = record
		function_name: widestring;
		function_ptr: pointer
	end;


const
	NEWTON_MAJOR_VERSION			=	3;
	NEWTON_MINOR_VERSION			=	14;
	NEWTON_BROADPHASE_DEFAULT			=	0;
	NEWTON_BROADPHASE_PERSINTENT			=	1;
	NEWTON_DYNAMIC_BODY			=	0;
	NEWTON_KINEMATIC_BODY			=	1;
	NEWTON_DYNAMIC_ASYMETRIC_BODY			=	2;
	SERIALIZE_ID_SPHERE			=	0;
	SERIALIZE_ID_CAPSULE			=	1;
	SERIALIZE_ID_CYLINDER			=	2;
	SERIALIZE_ID_CHAMFERCYLINDER			=	3;
	SERIALIZE_ID_BOX			=	4;
	SERIALIZE_ID_CONE			=	5;
	SERIALIZE_ID_CONVEXHULL			=	6;
	SERIALIZE_ID_NULL			=	7;
	SERIALIZE_ID_COMPOUND			=	8;
	SERIALIZE_ID_TREE			=	9;
	SERIALIZE_ID_HEIGHTFIELD			=	10;
	SERIALIZE_ID_CLOTH_PATCH			=	11;
	SERIALIZE_ID_DEFORMABLE_SOLID			=	12;
	SERIALIZE_ID_USERMESH			=	13;
	SERIALIZE_ID_SCENE			=	14;
	SERIALIZE_ID_FRACTURED_COMPOUND			=	15;


type

TNewtonCollisionMaterial = packed record
	m_userData: Pointer;
	m_userId: Integer;
	m_userFlags: Integer;
	m_userParam: array[0..7] of dfloat;
end;
PNewtonCollisionMaterial = ^TNewtonCollisionMaterial;

TNewtonBoxParam = packed record
	m_x: dfloat;
	m_y: dfloat;
	m_z: dfloat;
end;
PNewtonBoxParam = ^TNewtonBoxParam;

TNewtonSphereParam = packed record
	m_radio: dfloat;
end;
PNewtonSphereParam = ^TNewtonSphereParam;

TNewtonCapsuleParam = packed record
	m_radio0: dfloat;
	m_radio1: dfloat;
	m_height: dfloat;
end;
PNewtonCapsuleParam = ^TNewtonCapsuleParam;

TNewtonCylinderParam = packed record
	m_radio0: dfloat;
	m_radio1: dfloat;
	m_height: dfloat;
end;
PNewtonCylinderParam = ^TNewtonCylinderParam;

TNewtonConeParam = packed record
	m_radio: dfloat;
	m_height: dfloat;
end;
PNewtonConeParam = ^TNewtonConeParam;

TNewtonChamferCylinderParam = packed record
	m_radio: dfloat;
	m_height: dfloat;
end;
PNewtonChamferCylinderParam = ^TNewtonChamferCylinderParam;

TNewtonConvexHullParam = packed record
	m_vertexCount: Integer;
	m_vertexStrideInBytes: Integer;
	m_faceCount: Integer;
	m_vertex: pfloat;
end;
PNewtonConvexHullParam = ^TNewtonConvexHullParam;

TNewtonCompoundCollisionParam = packed record
	m_chidrenCount: Integer;
end;
PNewtonCompoundCollisionParam = ^TNewtonCompoundCollisionParam;

TNewtonCollisionTreeParam = packed record
	m_vertexCount: Integer;
	m_indexCount: Integer;
end;
PNewtonCollisionTreeParam = ^TNewtonCollisionTreeParam;

TNewtonDeformableMeshParam = packed record
	m_vertexCount: Integer;
	m_triangleCount: Integer;
	m_vrtexStrideInBytes: Integer;
	m_indexList: Pword;
	m_vertexList: Pdfloat;
end;
PNewtonDeformableMeshParam = ^TNewtonDeformableMeshParam;

TNewtonHeightFieldCollisionParam = packed record
	m_width: Integer;
	m_height: Integer;
	m_gridsDiagonals: Integer;
	m_elevationDataType: Integer;
	m_verticalScale: dfloat;
	m_horizonalScale_x: dfloat;
	m_horizonalScale_z: dfloat;
	m_horizonalDisplacementScale_x: dfloat;
	m_horizonalDisplacementScale_z: dfloat;
	m_vertialElevation: Pointer;
	m_horizotalDisplacement: pSmallInt;
	m_atributes: pchar;
end;
PNewtonHeightFieldCollisionParam = ^TNewtonHeightFieldCollisionParam;

TNewtonSceneCollisionParam = packed record
	m_childrenProxyCount: Integer;
end;
PNewtonSceneCollisionParam = ^TNewtonSceneCollisionParam;

TNewtonCollisionInfoRecord = packed record
	m_offsetMatrix: array[0..3, 0..3] of single;
	m_collisionMaterial: TNewtonCollisionMaterial;
	m_collisionType: integer;
	case integer of
	SERIALIZE_ID_BOX:
	(shapedatabox: TNewtonBoxParam);
	SERIALIZE_ID_CONE:
	(shapedata: TNewtonConeParam);
	SERIALIZE_ID_SPHERE:
	(shapedatasphere: TNewtonSphereParam);
	SERIALIZE_ID_CAPSULE:
	(shapedatacapsule: TNewtonCapsuleParam);
	SERIALIZE_ID_CYLINDER:
	(shapedatacylinder: TNewtonCylinderParam);
	//SERIALIZE_ID_TAPEREDCAPSULE:
	//(m_taperedCapsule: TNewtonTaperedCapsuleParam);
	//SERIALIZE_ID_TAPEREDCYLINDER:
	//(m_taperedCylinder: TNewtonTaperedCylinderParam);
	SERIALIZE_ID_CHAMFERCYLINDER:
	(shapedatachamfercylinder: TNewtonChamferCylinderParam);
	SERIALIZE_ID_CONVEXHULL:
	(shapedataconvexhull: TNewtonConvexHullParam);
	SERIALIZE_ID_DEFORMABLE_SOLID:
	(m_deformableMesh: TNewtonDeformableMeshParam);
	SERIALIZE_ID_COMPOUND:
	(shapedatacompound: TNewtonCompoundCollisionParam);
	SERIALIZE_ID_TREE:
	(shapedatatree: TNewtonCollisionTreeParam);
	SERIALIZE_ID_HEIGHTFIELD:
	(shapedataheightfield: TNewtonHeightFieldCollisionParam);
	SERIALIZE_ID_SCENE:
	(shapedatascenecollision: TNewtonSceneCollisionParam);
	SERIALIZE_ID_USERMESH:
	(m_paramArray: array[0..63] of float);
end;
PNewtonCollisionInfoRecord = ^TNewtonCollisionInfoRecord;

TNewtonJointRecord = packed record
	m_attachmenMatrix_0: array[0..3, 0..3] of dfloat;
	m_attachmenMatrix_1: array[0..3, 0..3] of dfloat;
	m_minLinearDof: array[0..2] of dfloat;
	m_maxLinearDof: array[0..2] of dfloat;
	m_minAngularDof: array[0..2] of dfloat;
	m_maxAngularDof: array[0..2] of dfloat;
	m_attachBody_0: pNewtonBody;
	m_attachBody_1: pNewtonBody;
	m_extraParameters: array[0..63] of dfloat;
	m_bodiesCollisionOn: Integer;
	m_descriptionType: array[0..127] of AnsiChar;
end;
PNewtonJointRecord = ^TNewtonJointRecord;

TNewtonUserMeshCollisionCollideDesc = packed record
	m_boxP0: array[0..3] of dfloat;
	m_boxP1: array[0..3] of dfloat;
	m_boxDistanceTravel: array[0..3] of dfloat;
	m_threadNumber: Integer;
	m_faceCount: Integer;
	m_vertexStrideInBytes: Integer;
	m_skinThickness: dfloat;
	m_userData: Pointer;
	m_objBody: pNewtonBody;
	m_polySoupBody: pNewtonBody;
	m_objCollision: PNewtonCollision;
	m_polySoupCollision: PNewtonCollision;
	m_vertex: pfloat;
	m_faceIndexCount: Pinteger;
	m_faceVertexIndex: Pinteger;
end;
PNewtonUserMeshCollisionCollideDesc = ^TNewtonUserMeshCollisionCollideDesc;

TNewtonWorldConvexCastReturnInfo = packed record
	m_point: array[0..3] of dfloat;
	m_normal: array[0..3] of dfloat;
	m_contactID: int64;
	m_hitBody: pNewtonBody;
	m_penetration: dfloat;
end;
PNewtonWorldConvexCastReturnInfo = ^TNewtonWorldConvexCastReturnInfo;

TNewtonUserMeshCollisionRayHitDesc = packed record
	m_p0: array[0..3] of dfloat;
	m_p1: array[0..3] of dfloat;
	m_normalOut: array[0..3] of dfloat;
	m_userIdOut: int64;
	m_userData: Pointer;
end;
PNewtonUserMeshCollisionRayHitDesc = ^TNewtonUserMeshCollisionRayHitDesc;

TNewtonHingeSliderUpdateDesc = packed record
	m_accel: dfloat;
	m_minFriction: dfloat;
	m_maxFriction: dfloat;
	m_timestep: dfloat;
end;
PNewtonHingeSliderUpdateDesc = ^TNewtonHingeSliderUpdateDesc;

TNewtonUserContactPoint = packed record
	m_point: array[0..3] of dfloat;
	m_normal: array[0..3] of dfloat;
	m_shapeId0: int64;
	m_shapeId1: int64;
	m_penetration: dfloat;
	m_unused: array[0..2] of Integer;
end;
PNewtonUserContactPoint = ^TNewtonUserContactPoint;

TNewtonImmediateModeConstraint = packed record
	m_jacobian01: array[0..7, 0..5] of dfloat;
	m_jacobian10: array[0..7, 0..5] of dfloat;
	m_minFriction: array[0..7] of dfloat;
	m_maxFriction: array[0..7] of dfloat;
	m_jointAccel: array[0..7] of dfloat;
	m_jointStiffness: array[0..7] of dfloat;
end;
PNewtonImmediateModeConstraint = ^TNewtonImmediateModeConstraint;

TNewtonMeshDoubleData = packed record
	m_data: Pdouble;
	m_indexList: Pinteger;
	m_strideInBytes: Integer;
end;
PNewtonMeshDoubleData = ^TNewtonMeshDoubleData;

TNewtonMeshFloatData = packed record
	m_data: pfloat;
	m_indexList: Pinteger;
	m_strideInBytes: Integer;
end;
PNewtonMeshFloatData = ^TNewtonMeshFloatData;

TNewtonMeshVertexFormat = packed record
	m_faceCount: Integer;
	m_faceIndexCount: Pinteger;
	m_faceMaterial: Pinteger;
	m_vertex: TNewtonMeshDoubleData;
	m_normal: TNewtonMeshFloatData;
	m_binormal: TNewtonMeshFloatData;
	m_uv0: TNewtonMeshFloatData;
	m_uv1: TNewtonMeshFloatData;
	m_vertexColor: TNewtonMeshFloatData;
end;
PNewtonMeshVertexFormat = ^TNewtonMeshVertexFormat;

NewtonAllocMemory = function(sizeInBytes: Integer): Pointer; cdecl;
PNewtonAllocMemory = ^NewtonAllocMemory;

NewtonFreeMemory = procedure(const ptr: Pointer; sizeInBytes: Integer); cdecl;
PNewtonFreeMemory = ^NewtonFreeMemory;

NewtonWorldDestructorCallback = procedure(const world: PNewtonWorld); cdecl;
PNewtonWorldDestructorCallback = ^NewtonWorldDestructorCallback;

NewtonPostUpdateCallback = procedure(const world: PNewtonWorld; timestep: dfloat); cdecl;
PNewtonPostUpdateCallback = ^NewtonPostUpdateCallback;

NewtonCreateContactCallback = procedure(const newtonWorld: PNewtonWorld; const contact: PNewtonJoint); cdecl;
PNewtonCreateContactCallback = ^NewtonCreateContactCallback;

NewtonDestroyContactCallback = procedure(const newtonWorld: PNewtonWorld; const contact: PNewtonJoint); cdecl;
PNewtonDestroyContactCallback = ^NewtonDestroyContactCallback;

NewtonWorldListenerDebugCallback = procedure(const world: PNewtonWorld; const listener: Pointer; const debugContext: Pointer); cdecl;
PNewtonWorldListenerDebugCallback = ^NewtonWorldListenerDebugCallback;

NewtonWorldListenerBodyDestroyCallback = procedure(const world: PNewtonWorld; const listenerUserData: Pointer; const body: pNewtonBody); cdecl;
PNewtonWorldListenerBodyDestroyCallback = ^NewtonWorldListenerBodyDestroyCallback;

NewtonWorldUpdateListenerCallback = procedure(const world: PNewtonWorld; const listenerUserData: Pointer; timestep: dfloat); cdecl;
PNewtonWorldUpdateListenerCallback = ^NewtonWorldUpdateListenerCallback;

NewtonWorldDestroyListenerCallback = procedure(const world: PNewtonWorld; const listenerUserData: Pointer); cdecl;
PNewtonWorldDestroyListenerCallback = ^NewtonWorldDestroyListenerCallback;

NewtonGetTimeInMicrosencondsCallback = function(): int64; cdecl;
PNewtonGetTimeInMicrosencondsCallback = ^NewtonGetTimeInMicrosencondsCallback;

NewtonSerializeCallback = procedure(const serializeHandle: Pointer; const buffer: Pointer; size: Integer); cdecl;
PNewtonSerializeCallback = ^NewtonSerializeCallback;

NewtonDeserializeCallback = procedure(const serializeHandle: Pointer; const buffer: Pointer; size: Integer); cdecl;
PNewtonDeserializeCallback = ^NewtonDeserializeCallback;

NewtonOnBodySerializationCallback = procedure(const body: pNewtonBody; const userData: Pointer; functionparam: PNewtonSerializeCallback; const serializeHandle: Pointer); cdecl;
PNewtonOnBodySerializationCallback = ^NewtonOnBodySerializationCallback;

NewtonOnBodyDeserializationCallback = procedure(const body: pNewtonBody; const userData: Pointer; functionparam: PNewtonDeserializeCallback; const serializeHandle: Pointer); cdecl;
PNewtonOnBodyDeserializationCallback = ^NewtonOnBodyDeserializationCallback;

NewtonOnJointSerializationCallback = procedure(const joint: PNewtonJoint; functionparam: PNewtonSerializeCallback; const serializeHandle: Pointer); cdecl;
PNewtonOnJointSerializationCallback = ^NewtonOnJointSerializationCallback;

NewtonOnJointDeserializationCallback = procedure(const body0: pNewtonBody; const body1: pNewtonBody; functionparam: PNewtonDeserializeCallback; const serializeHandle: Pointer); cdecl;
PNewtonOnJointDeserializationCallback = ^NewtonOnJointDeserializationCallback;

NewtonOnUserCollisionSerializationCallback = procedure(const userData: Pointer; functionparam: PNewtonSerializeCallback; const serializeHandle: Pointer); cdecl;
PNewtonOnUserCollisionSerializationCallback = ^NewtonOnUserCollisionSerializationCallback;

NewtonUserMeshCollisionDestroyCallback = procedure(const userData: Pointer); cdecl;
PNewtonUserMeshCollisionDestroyCallback = ^NewtonUserMeshCollisionDestroyCallback;

NewtonUserMeshCollisionRayHitCallback = function(const lineDescData: PNewtonUserMeshCollisionRayHitDesc): dfloat; cdecl;
PNewtonUserMeshCollisionRayHitCallback = ^NewtonUserMeshCollisionRayHitCallback;

NewtonUserMeshCollisionGetCollisionInfo = procedure(const userData: Pointer; const infoRecord: PNewtonCollisionInfoRecord); cdecl;
PNewtonUserMeshCollisionGetCollisionInfo = ^NewtonUserMeshCollisionGetCollisionInfo;

NewtonUserMeshCollisionAABBTest = function(const userData: Pointer; const boxP0: pfloat; const boxP1: pfloat): Integer; cdecl;
PNewtonUserMeshCollisionAABBTest = ^NewtonUserMeshCollisionAABBTest;

NewtonUserMeshCollisionGetFacesInAABB = function(const userData: Pointer; const p0: pfloat; const p1: pfloat; const vertexArray: Pfloat; const vertexCount: Pinteger; const vertexStrideInBytes: Pinteger; const indexList: Pinteger; maxIndexCount: Integer; const userDataList: Pinteger): Integer; cdecl;
PNewtonUserMeshCollisionGetFacesInAABB = ^NewtonUserMeshCollisionGetFacesInAABB;

NewtonUserMeshCollisionCollideCallback = procedure(const collideDescData: PNewtonUserMeshCollisionCollideDesc; const continueCollisionHandle: Pointer); cdecl;
PNewtonUserMeshCollisionCollideCallback = ^NewtonUserMeshCollisionCollideCallback;

NewtonTreeCollisionFaceCallback = function(const context: Pointer; const polygon: pfloat; strideInBytes: Integer; const indexArray: Pinteger; indexCount: Integer): Integer; cdecl;
PNewtonTreeCollisionFaceCallback = ^NewtonTreeCollisionFaceCallback;

NewtonCollisionTreeRayCastCallback = function(const body: pNewtonBody; const treeCollision: PNewtonCollision; intersection: dfloat; const normal: pfloat; faceId: Integer; const usedData: Pointer): dfloat; cdecl;
PNewtonCollisionTreeRayCastCallback = ^NewtonCollisionTreeRayCastCallback;

NewtonHeightFieldRayCastCallback = function(const body: pNewtonBody; const heightFieldCollision: PNewtonCollision; intersection: dfloat; row: Integer; col: Integer; const normal: pfloat; faceId: Integer; const usedData: Pointer): dfloat; cdecl;
PNewtonHeightFieldRayCastCallback = ^NewtonHeightFieldRayCastCallback;

NewtonCollisionCopyConstructionCallback = procedure(const newtonWorld: PNewtonWorld; const collision: PNewtonCollision; const sourceCollision: PNewtonCollision); cdecl;
PNewtonCollisionCopyConstructionCallback = ^NewtonCollisionCopyConstructionCallback;

NewtonCollisionDestructorCallback = procedure(const newtonWorld: PNewtonWorld; const collision: PNewtonCollision); cdecl;
PNewtonCollisionDestructorCallback = ^NewtonCollisionDestructorCallback;

NewtonTreeCollisionCallback = procedure(const bodyWithTreeCollision: pNewtonBody; const body: pNewtonBody; faceID: Integer; vertexCount: Integer; const vertex: pfloat; vertexStrideInBytes: Integer); cdecl;
PNewtonTreeCollisionCallback = ^NewtonTreeCollisionCallback;

NewtonBodyDestructor = procedure(const body: pNewtonBody); cdecl;
PNewtonBodyDestructor = ^NewtonBodyDestructor;

NewtonApplyForceAndTorque = procedure(const body: pNewtonBody; timestep: dfloat; threadIndex: Integer); cdecl;
PNewtonApplyForceAndTorque = ^NewtonApplyForceAndTorque;

NewtonSetTransform = procedure(const body: pNewtonBody; const matrix: pfloat; threadIndex: Integer); cdecl;
PNewtonSetTransform = ^NewtonSetTransform;

NewtonIslandUpdate = function(const newtonWorld: PNewtonWorld; const islandHandle: Pointer; bodyCount: Integer): Integer; cdecl;
PNewtonIslandUpdate = ^NewtonIslandUpdate;

NewtonFractureCompoundCollisionOnEmitCompoundFractured = procedure(const fracturedBody: pNewtonBody); cdecl;
PNewtonFractureCompoundCollisionOnEmitCompoundFractured = ^NewtonFractureCompoundCollisionOnEmitCompoundFractured;

NewtonFractureCompoundCollisionOnEmitChunk = procedure(const chunkBody: pNewtonBody; const fracturexChunkMesh: PNewtonFracturedCompoundMeshPart; const fracturedCompountCollision: PNewtonCollision); cdecl;
PNewtonFractureCompoundCollisionOnEmitChunk = ^NewtonFractureCompoundCollisionOnEmitChunk;

NewtonFractureCompoundCollisionReconstructMainMeshCallBack = procedure(const body: pNewtonBody; const mainMesh: PNewtonFracturedCompoundMeshPart; const fracturedCompountCollision: PNewtonCollision); cdecl;
PNewtonFractureCompoundCollisionReconstructMainMeshCallBack = ^NewtonFractureCompoundCollisionReconstructMainMeshCallBack;

NewtonWorldRayPrefilterCallback = function(const body: pNewtonBody; const collision: PNewtonCollision; const userData: Pointer): LongWord; cdecl;
PNewtonWorldRayPrefilterCallback = ^NewtonWorldRayPrefilterCallback;

NewtonWorldRayFilterCallback = function(const body: pNewtonBody; const shapeHit: PNewtonCollision; const hitContact: pfloat; const hitNormal: pfloat; collisionID: int64; const userData: Pointer; intersectParam: dfloat): dfloat; cdecl;
PNewtonWorldRayFilterCallback = ^NewtonWorldRayFilterCallback;

NewtonOnAABBOverlap = function(const contact: PNewtonJoint; timestep: dfloat; threadIndex: Integer): Integer; cdecl;
PNewtonOnAABBOverlap = ^NewtonOnAABBOverlap;

NewtonContactsProcess = procedure(const contact: PNewtonJoint; timestep: dfloat; threadIndex: Integer); cdecl;
PNewtonContactsProcess = ^NewtonContactsProcess;

NewtonOnCompoundSubCollisionAABBOverlap = function(const contact: PNewtonJoint; timestep: dfloat; const body0: pNewtonBody; const collisionNode0: Pointer; const body1: pNewtonBody; const collisionNode1: Pointer; threadIndex: Integer): Integer; cdecl;
PNewtonOnCompoundSubCollisionAABBOverlap = ^NewtonOnCompoundSubCollisionAABBOverlap;

NewtonOnContactGeneration = function(const material: PNewtonMaterial; const body0: pNewtonBody; const collision0: PNewtonCollision; const body1: pNewtonBody; const collision1: PNewtonCollision; const contactBuffer: PNewtonUserContactPoint; maxCount: Integer; threadIndex: Integer): Integer; cdecl;
PNewtonOnContactGeneration = ^NewtonOnContactGeneration;

NewtonBodyIterator = function(const body: pNewtonBody; const userData: Pointer): Integer; cdecl;
PNewtonBodyIterator = ^NewtonBodyIterator;

NewtonJointIterator = procedure(const joint: PNewtonJoint; const userData: Pointer); cdecl;
PNewtonJointIterator = ^NewtonJointIterator;

NewtonCollisionIterator = procedure(const userData: Pointer; vertexCount: Integer; const faceArray: pfloat; faceId: Integer); cdecl;
PNewtonCollisionIterator = ^NewtonCollisionIterator;

NewtonBallCallback = procedure(const ball: PNewtonJoint; timestep: dfloat); cdecl;
PNewtonBallCallback = ^NewtonBallCallback;

NewtonHingeCallback = function(const hinge: PNewtonJoint; const desc: PNewtonHingeSliderUpdateDesc): LongWord; cdecl;
PNewtonHingeCallback = ^NewtonHingeCallback;

NewtonSliderCallback = function(const slider: PNewtonJoint; const desc: PNewtonHingeSliderUpdateDesc): LongWord; cdecl;
PNewtonSliderCallback = ^NewtonSliderCallback;

NewtonUniversalCallback = function(const universal: PNewtonJoint; const desc: PNewtonHingeSliderUpdateDesc): LongWord; cdecl;
PNewtonUniversalCallback = ^NewtonUniversalCallback;

NewtonCorkscrewCallback = function(const corkscrew: PNewtonJoint; const desc: PNewtonHingeSliderUpdateDesc): LongWord; cdecl;
PNewtonCorkscrewCallback = ^NewtonCorkscrewCallback;

NewtonUserBilateralCallback = procedure(const userJoint: PNewtonJoint; timestep: dfloat; threadIndex: Integer); cdecl;
PNewtonUserBilateralCallback = ^NewtonUserBilateralCallback;

NewtonUserBilateralGetInfoCallback = procedure(const userJoint: PNewtonJoint; const info: PNewtonJointRecord); cdecl;
PNewtonUserBilateralGetInfoCallback = ^NewtonUserBilateralGetInfoCallback;

NewtonConstraintDestructor = procedure(const me: PNewtonJoint); cdecl;
PNewtonConstraintDestructor = ^NewtonConstraintDestructor;

NewtonJobTask = procedure(const world: PNewtonWorld; const userData: Pointer; threadIndex: Integer); cdecl;
PNewtonJobTask = ^NewtonJobTask;

NewtonReportProgress = function(normalizedProgressPercent: dfloat; const userData: Pointer): Integer; cdecl;
PNewtonReportProgress = ^NewtonReportProgress;

{ world control functions }
function NewtonWorldGetVersion (): Integer; cdecl; external newtondll;
function NewtonWorldFloatSize (): Integer; cdecl; external newtondll;
function NewtonGetMemoryUsed (): Integer; cdecl; external newtondll;
procedure NewtonSetMemorySystem (malloc: NewtonAllocMemory; free: NewtonFreeMemory); cdecl; external newtondll;
function NewtonCreate (): PNewtonWorld; cdecl; external newtondll;
procedure NewtonDestroy (const newtonWorld: PNewtonWorld); cdecl; external newtondll;
procedure NewtonDestroyAllBodies (const newtonWorld: PNewtonWorld); cdecl; external newtondll;
function NewtonGetPostUpdateCallback (const newtonWorld: PNewtonWorld): PNewtonPostUpdateCallback; cdecl; external newtondll;
procedure NewtonSetPostUpdateCallback (const newtonWorld: PNewtonWorld; callback: NewtonPostUpdateCallback); cdecl; external newtondll;
function NewtonAlloc (sizeInBytes: Integer): Pointer; cdecl; external newtondll;
procedure NewtonFree (const ptr: Pointer); cdecl; external newtondll;
procedure NewtonLoadPlugins (const newtonWorld: PNewtonWorld; const plugInPath: pchar); cdecl; external newtondll;
procedure NewtonUnloadPlugins (const newtonWorld: PNewtonWorld); cdecl; external newtondll;
function NewtonCurrentPlugin (const newtonWorld: PNewtonWorld): Pointer; cdecl; external newtondll;
function NewtonGetFirstPlugin (const newtonWorld: PNewtonWorld): Pointer; cdecl; external newtondll;
function NewtonGetPreferedPlugin (const newtonWorld: PNewtonWorld): Pointer; cdecl; external newtondll;
function NewtonGetNextPlugin (const newtonWorld: PNewtonWorld; const plugin: Pointer): Pointer; cdecl; external newtondll;
function NewtonGetPluginString (const newtonWorld: PNewtonWorld; const plugin: Pointer): pchar; cdecl; external newtondll;
procedure NewtonSelectPlugin (const newtonWorld: PNewtonWorld; const plugin: Pointer); cdecl; external newtondll;
function NewtonGetContactMergeTolerance (const newtonWorld: PNewtonWorld): dfloat; cdecl; external newtondll;
procedure NewtonSetContactMergeTolerance (const newtonWorld: PNewtonWorld; tolerance: dfloat); cdecl; external newtondll;
procedure NewtonInvalidateCache (const newtonWorld: PNewtonWorld); cdecl; external newtondll;
procedure NewtonSetSolverIterations (const newtonWorld: PNewtonWorld; model: Integer); cdecl; external newtondll;
function NewtonGetSolverIterations (const newtonWorld: PNewtonWorld): Integer; cdecl; external newtondll;
procedure NewtonSetParallelSolverOnLargeIsland (const newtonWorld: PNewtonWorld; mode: Integer); cdecl; external newtondll;
function NewtonGetParallelSolverOnLargeIsland (const newtonWorld: PNewtonWorld): Integer; cdecl; external newtondll;
function NewtonGetBroadphaseAlgorithm (const newtonWorld: PNewtonWorld): Integer; cdecl; external newtondll;
procedure NewtonSelectBroadphaseAlgorithm (const newtonWorld: PNewtonWorld; algorithmType: Integer); cdecl; external newtondll;
procedure NewtonResetBroadphase (const newtonWorld: PNewtonWorld); cdecl; external newtondll;
procedure NewtonUpdate (const newtonWorld: PNewtonWorld; timestep: dfloat); cdecl; external newtondll;
procedure NewtonUpdateAsync (const newtonWorld: PNewtonWorld; timestep: dfloat); cdecl; external newtondll;
procedure NewtonWaitForUpdateToFinish (const newtonWorld: PNewtonWorld); cdecl; external newtondll;
function NewtonGetNumberOfSubsteps (const newtonWorld: PNewtonWorld): Integer; cdecl; external newtondll;
procedure NewtonSetNumberOfSubsteps (const newtonWorld: PNewtonWorld; subSteps: Integer); cdecl; external newtondll;
function NewtonGetLastUpdateTime (const newtonWorld: PNewtonWorld): dfloat; cdecl; external newtondll;
procedure NewtonSerializeToFile (const newtonWorld: PNewtonWorld; const filename: pchar; bodyCallback: NewtonOnBodySerializationCallback; const bodyUserData: Pointer); cdecl; external newtondll;
procedure NewtonDeserializeFromFile (const newtonWorld: PNewtonWorld; const filename: pchar; bodyCallback: NewtonOnBodyDeserializationCallback; const bodyUserData: Pointer); cdecl; external newtondll;
procedure NewtonSerializeScene (const newtonWorld: PNewtonWorld; bodyCallback: NewtonOnBodySerializationCallback; const bodyUserData: Pointer; serializeCallback: NewtonSerializeCallback; const serializeHandle: Pointer); cdecl; external newtondll;
procedure NewtonDeserializeScene (const newtonWorld: PNewtonWorld; bodyCallback: NewtonOnBodyDeserializationCallback; const bodyUserData: Pointer; serializeCallback: NewtonDeserializeCallback; const serializeHandle: Pointer); cdecl; external newtondll;
function NewtonFindSerializedBody (const newtonWorld: PNewtonWorld; bodySerializedID: Integer): pNewtonBody; cdecl; external newtondll;
procedure NewtonSetJointSerializationCallbacks (const newtonWorld: PNewtonWorld; serializeJoint: NewtonOnJointSerializationCallback; deserializeJoint: NewtonOnJointDeserializationCallback); cdecl; external newtondll;
procedure NewtonGetJointSerializationCallbacks (const newtonWorld: PNewtonWorld; const serializeJoint: NewtonOnJointSerializationCallback; const deserializeJoint: NewtonOnJointDeserializationCallback); cdecl; external newtondll;
procedure NewtonWorldCriticalSectionLock (const newtonWorld: PNewtonWorld; threadIndex: Integer); cdecl; external newtondll;
procedure NewtonWorldCriticalSectionUnlock (const newtonWorld: PNewtonWorld); cdecl; external newtondll;
procedure NewtonSetThreadsCount (const newtonWorld: PNewtonWorld; threads: Integer); cdecl; external newtondll;
function NewtonGetThreadsCount (const newtonWorld: PNewtonWorld): Integer; cdecl; external newtondll;
function NewtonGetMaxThreadsCount (const newtonWorld: PNewtonWorld): Integer; cdecl; external newtondll;
procedure NewtonDispachThreadJob (const newtonWorld: PNewtonWorld; task: NewtonJobTask; const usedData: Pointer; const functionName: pchar); cdecl; external newtondll;
procedure NewtonSyncThreadJobs (const newtonWorld: PNewtonWorld); cdecl; external newtondll;
function NewtonAtomicAdd (const ptr: Pinteger; value: Integer): Integer; cdecl; external newtondll;
function NewtonAtomicSwap (const ptr: Pinteger; value: Integer): Integer; cdecl; external newtondll;
procedure NewtonYield (); cdecl; external newtondll;
procedure NewtonSetIslandUpdateEvent (const newtonWorld: PNewtonWorld; islandUpdate: NewtonIslandUpdate); cdecl; external newtondll;
procedure NewtonWorldForEachJointDo (const newtonWorld: PNewtonWorld; callback: NewtonJointIterator; const userData: Pointer); cdecl; external newtondll;
procedure NewtonWorldForEachBodyInAABBDo (const newtonWorld: PNewtonWorld; const p0: pfloat; const p1: pfloat; callback: NewtonBodyIterator; const userData: Pointer); cdecl; external newtondll;
procedure NewtonWorldSetUserData (const newtonWorld: PNewtonWorld; const userData: Pointer); cdecl; external newtondll;
function NewtonWorldGetUserData (const newtonWorld: PNewtonWorld): Pointer; cdecl; external newtondll;
function NewtonWorldAddListener (const newtonWorld: PNewtonWorld; const nameId: pchar; const listenerUserData: Pointer): Pointer; cdecl; external newtondll;
function NewtonWorldGetListener (const newtonWorld: PNewtonWorld; const nameId: pchar): Pointer; cdecl; external newtondll;
procedure NewtonWorldListenerSetDestructorCallback (const newtonWorld: PNewtonWorld; const listener: Pointer; destroy: NewtonWorldDestroyListenerCallback); cdecl; external newtondll;
procedure NewtonWorldListenerSetPreUpdateCallback (const newtonWorld: PNewtonWorld; const listener: Pointer; update: NewtonWorldUpdateListenerCallback); cdecl; external newtondll;
procedure NewtonWorldListenerSetPostUpdateCallback (const newtonWorld: PNewtonWorld; const listener: Pointer; update: NewtonWorldUpdateListenerCallback); cdecl; external newtondll;
procedure NewtonWorldListenerSetDebugCallback (const newtonWorld: PNewtonWorld; const listener: Pointer; debugCallback: NewtonWorldListenerDebugCallback); cdecl; external newtondll;
procedure NewtonWorldListenerSetBodyDestroyCallback (const newtonWorld: PNewtonWorld; const listener: Pointer; bodyDestroyCallback: NewtonWorldListenerBodyDestroyCallback); cdecl; external newtondll;
procedure NewtonWorldListenerDebug (const newtonWorld: PNewtonWorld; const context: Pointer); cdecl; external newtondll;
function NewtonWorldGetListenerUserData (const newtonWorld: PNewtonWorld; const listener: Pointer): Pointer; cdecl; external newtondll;
function NewtonWorldListenerGetBodyDestroyCallback (const newtonWorld: PNewtonWorld; const listener: Pointer): PNewtonWorldListenerBodyDestroyCallback; cdecl; external newtondll;
procedure NewtonWorldSetDestructorCallback (const newtonWorld: PNewtonWorld; destructorparam: NewtonWorldDestructorCallback); cdecl; external newtondll;
function NewtonWorldGetDestructorCallback (const newtonWorld: PNewtonWorld): PNewtonWorldDestructorCallback; cdecl; external newtondll;
procedure NewtonWorldSetCollisionConstructorDestructorCallback (const newtonWorld: PNewtonWorld; constructorparam: NewtonCollisionCopyConstructionCallback; destructorparam: NewtonCollisionDestructorCallback); cdecl; external newtondll;
procedure NewtonWorldSetCreateDestroyContactCallback (const newtonWorld: PNewtonWorld; createContact: NewtonCreateContactCallback; destroyContact: NewtonDestroyContactCallback); cdecl; external newtondll;
procedure NewtonWorldRayCast (const newtonWorld: PNewtonWorld; const p0: pfloat; const p1: pfloat; filter: NewtonWorldRayFilterCallback; const userData: Pointer; prefilter: NewtonWorldRayPrefilterCallback; threadIndex: Integer); cdecl; external newtondll;
function NewtonWorldConvexCast (const newtonWorld: PNewtonWorld; const matrix: pfloat; const target: pfloat; const shape: PNewtonCollision; const param: pfloat; const userData: Pointer; prefilter: NewtonWorldRayPrefilterCallback; const info: PNewtonWorldConvexCastReturnInfo; maxContactsCount: Integer; threadIndex: Integer): Integer; cdecl; external newtondll;
function NewtonWorldCollide (const newtonWorld: PNewtonWorld; const matrix: pfloat; const shape: PNewtonCollision; const userData: Pointer; prefilter: NewtonWorldRayPrefilterCallback; const info: PNewtonWorldConvexCastReturnInfo; maxContactsCount: Integer; threadIndex: Integer): Integer; cdecl; external newtondll;
function NewtonWorldGetBodyCount (const newtonWorld: PNewtonWorld): Integer; cdecl; external newtondll;
function NewtonWorldGetConstraintCount (const newtonWorld: PNewtonWorld): Integer; cdecl; external newtondll;
{ Simulation islands }
function NewtonIslandGetBody (const island: Pointer; bodyIndex: Integer): pNewtonBody; cdecl; external newtondll;
procedure NewtonIslandGetBodyAABB (const island: Pointer; bodyIndex: Integer; const p0: pfloat; const p1: pfloat); cdecl; external newtondll;
{ Physics Material Section }
function NewtonMaterialCreateGroupID (const newtonWorld: PNewtonWorld): Integer; cdecl; external newtondll;
function NewtonMaterialGetDefaultGroupID (const newtonWorld: PNewtonWorld): Integer; cdecl; external newtondll;
procedure NewtonMaterialDestroyAllGroupID (const newtonWorld: PNewtonWorld); cdecl; external newtondll;
function NewtonMaterialGetUserData (const newtonWorld: PNewtonWorld; id0: Integer; id1: Integer): Pointer; cdecl; external newtondll;
procedure NewtonMaterialSetSurfaceThickness (const newtonWorld: PNewtonWorld; id0: Integer; id1: Integer; thickness: dfloat); cdecl; external newtondll;
procedure NewtonMaterialSetCallbackUserData (const newtonWorld: PNewtonWorld; id0: Integer; id1: Integer; const userData: Pointer); cdecl; external newtondll;
procedure NewtonMaterialSetContactGenerationCallback (const newtonWorld: PNewtonWorld; id0: Integer; id1: Integer; contactGeneration: NewtonOnContactGeneration); cdecl; external newtondll;
procedure NewtonMaterialSetCompoundCollisionCallback (const newtonWorld: PNewtonWorld; id0: Integer; id1: Integer; compoundAabbOverlap: NewtonOnCompoundSubCollisionAABBOverlap); cdecl; external newtondll;
procedure NewtonMaterialSetCollisionCallback (const newtonWorld: PNewtonWorld; id0: Integer; id1: Integer; aabbOverlap: NewtonOnAABBOverlap; process: NewtonContactsProcess); cdecl; external newtondll;
procedure NewtonMaterialSetDefaultSoftness (const newtonWorld: PNewtonWorld; id0: Integer; id1: Integer; value: dfloat); cdecl; external newtondll;
procedure NewtonMaterialSetDefaultElasticity (const newtonWorld: PNewtonWorld; id0: Integer; id1: Integer; elasticCoef: dfloat); cdecl; external newtondll;
procedure NewtonMaterialSetDefaultCollidable (const newtonWorld: PNewtonWorld; id0: Integer; id1: Integer; state: Integer); cdecl; external newtondll;
procedure NewtonMaterialSetDefaultFriction (const newtonWorld: PNewtonWorld; id0: Integer; id1: Integer; staticFriction: dfloat; kineticFriction: dfloat); cdecl; external newtondll;
function NewtonWorldGetFirstMaterial (const newtonWorld: PNewtonWorld): PNewtonMaterial; cdecl; external newtondll;
function NewtonWorldGetNextMaterial (const newtonWorld: PNewtonWorld; const material: PNewtonMaterial): PNewtonMaterial; cdecl; external newtondll;
function NewtonWorldGetFirstBody (const newtonWorld: PNewtonWorld): pNewtonBody; cdecl; external newtondll;
function NewtonWorldGetNextBody (const newtonWorld: PNewtonWorld; const curBody: pNewtonBody): pNewtonBody; cdecl; external newtondll;
{ Physics Contact control functions }
function NewtonMaterialGetMaterialPairUserData (const material: PNewtonMaterial): Pointer; cdecl; external newtondll;
function NewtonMaterialGetContactFaceAttribute (const material: PNewtonMaterial): LongWord; cdecl; external newtondll;
function NewtonMaterialGetBodyCollidingShape (const material: PNewtonMaterial; const body: pNewtonBody): PNewtonCollision; cdecl; external newtondll;
function NewtonMaterialGetContactNormalSpeed (const material: PNewtonMaterial): dfloat; cdecl; external newtondll;
procedure NewtonMaterialGetContactForce (const material: PNewtonMaterial; const body: pNewtonBody; const force: pfloat); cdecl; external newtondll;
procedure NewtonMaterialGetContactPositionAndNormal (const material: PNewtonMaterial; const body: pNewtonBody; const posit: pfloat; const normal: pfloat); cdecl; external newtondll;
procedure NewtonMaterialGetContactTangentDirections (const material: PNewtonMaterial; const body: pNewtonBody; const dir0: pfloat; const dir1: pfloat); cdecl; external newtondll;
function NewtonMaterialGetContactTangentSpeed (const material: PNewtonMaterial; index: Integer): dfloat; cdecl; external newtondll;
function NewtonMaterialGetContactMaxNormalImpact (const material: PNewtonMaterial): dfloat; cdecl; external newtondll;
function NewtonMaterialGetContactMaxTangentImpact (const material: PNewtonMaterial; index: Integer): dfloat; cdecl; external newtondll;
function NewtonMaterialGetContactPenetration (const material: PNewtonMaterial): dfloat; cdecl; external newtondll;
procedure NewtonMaterialSetContactSoftness (const material: PNewtonMaterial; softness: dfloat); cdecl; external newtondll;
procedure NewtonMaterialSetContactThickness (const material: PNewtonMaterial; thickness: dfloat); cdecl; external newtondll;
procedure NewtonMaterialSetContactElasticity (const material: PNewtonMaterial; restitution: dfloat); cdecl; external newtondll;
procedure NewtonMaterialSetContactFrictionState (const material: PNewtonMaterial; state: Integer; index: Integer); cdecl; external newtondll;
procedure NewtonMaterialSetContactFrictionCoef (const material: PNewtonMaterial; staticFrictionCoef: dfloat; kineticFrictionCoef: dfloat; index: Integer); cdecl; external newtondll;
procedure NewtonMaterialSetContactNormalAcceleration (const material: PNewtonMaterial; accel: dfloat); cdecl; external newtondll;
procedure NewtonMaterialSetContactNormalDirection (const material: PNewtonMaterial; const directionVector: pfloat); cdecl; external newtondll;
procedure NewtonMaterialSetContactPosition (const material: PNewtonMaterial; const position: pfloat); cdecl; external newtondll;
procedure NewtonMaterialSetContactTangentFriction (const material: PNewtonMaterial; friction: dfloat; index: Integer); cdecl; external newtondll;
procedure NewtonMaterialSetContactTangentAcceleration (const material: PNewtonMaterial; accel: dfloat; index: Integer); cdecl; external newtondll;
procedure NewtonMaterialContactRotateTangentDirections (const material: PNewtonMaterial; const directionVector: pfloat); cdecl; external newtondll;
function NewtonMaterialGetContactPruningTolerance (const contactJoint: PNewtonJoint): dfloat; cdecl; external newtondll;
procedure NewtonMaterialSetContactPruningTolerance (const contactJoint: PNewtonJoint; tolerance: dfloat); cdecl; external newtondll;
{ convex collision primitives creation functions }
function NewtonCreateNull (const newtonWorld: PNewtonWorld): PNewtonCollision; cdecl; external newtondll;
function NewtonCreateSphere (const newtonWorld: PNewtonWorld; radius: dfloat; shapeID: Integer; const offsetMatrix: pfloat): PNewtonCollision; cdecl; external newtondll;
function NewtonCreateBox (const newtonWorld: PNewtonWorld; dx: dfloat; dy: dfloat; dz: dfloat; shapeID: Integer; const offsetMatrix: pfloat): PNewtonCollision; cdecl; external newtondll;
function NewtonCreateCone (const newtonWorld: PNewtonWorld; radius: dfloat; height: dfloat; shapeID: Integer; const offsetMatrix: pfloat): PNewtonCollision; cdecl; external newtondll;
function NewtonCreateCapsule (const newtonWorld: PNewtonWorld; radius0: dfloat; radius1: dfloat; height: dfloat; shapeID: Integer; const offsetMatrix: pfloat): PNewtonCollision; cdecl; external newtondll;
function NewtonCreateCylinder (const newtonWorld: PNewtonWorld; radio0: dfloat; radio1: dfloat; height: dfloat; shapeID: Integer; const offsetMatrix: pfloat): PNewtonCollision; cdecl; external newtondll;
function NewtonCreateChamferCylinder (const newtonWorld: PNewtonWorld; radius: dfloat; height: dfloat; shapeID: Integer; const offsetMatrix: pfloat): PNewtonCollision; cdecl; external newtondll;
function NewtonCreateConvexHull (const newtonWorld: PNewtonWorld; count: Integer; const vertexCloud: pfloat; strideInBytes: Integer; tolerance: dfloat; shapeID: Integer; const offsetMatrix: pfloat): PNewtonCollision; cdecl; external newtondll;
function NewtonCreateConvexHullFromMesh (const newtonWorld: PNewtonWorld; const mesh: PNewtonMesh; tolerance: dfloat; shapeID: Integer): PNewtonCollision; cdecl; external newtondll;
function NewtonCollisionGetMode (const convexCollision: PNewtonCollision): Integer; cdecl; external newtondll;
procedure NewtonCollisionSetMode (const convexCollision: PNewtonCollision; mode: Integer); cdecl; external newtondll;
function NewtonConvexHullGetFaceIndices (const convexHullCollision: PNewtonCollision; face: Integer; const faceIndices: Pinteger): Integer; cdecl; external newtondll;
function NewtonConvexHullGetVertexData (const convexHullCollision: PNewtonCollision; const vertexData: Pfloat; strideInBytes: Pinteger): Integer; cdecl; external newtondll;
function NewtonConvexCollisionCalculateVolume (const convexCollision: PNewtonCollision): dfloat; cdecl; external newtondll;
procedure NewtonConvexCollisionCalculateInertialMatrix (const convexCollision: PNewtonCollision; const inertia: pfloat; const origin: pfloat); cdecl; external newtondll;
function NewtonConvexCollisionCalculateBuoyancyVolume (const convexCollision: PNewtonCollision; const matrix: pfloat; const fluidPlane: pfloat; const centerOfBuoyancy: pfloat): dfloat; cdecl; external newtondll;
function NewtonCollisionDataPointer (const convexCollision: PNewtonCollision): Pointer; cdecl; external newtondll;
{ compound collision primitives creation functions }
function NewtonCreateCompoundCollision (const newtonWorld: PNewtonWorld; shapeID: Integer): PNewtonCollision; cdecl; external newtondll;
function NewtonCreateCompoundCollisionFromMesh (const newtonWorld: PNewtonWorld; const mesh: PNewtonMesh; hullTolerance: dfloat; shapeID: Integer; subShapeID: Integer): PNewtonCollision; cdecl; external newtondll;
procedure NewtonCompoundCollisionBeginAddRemove (const compoundCollision: PNewtonCollision); cdecl; external newtondll;
function NewtonCompoundCollisionAddSubCollision (const compoundCollision: PNewtonCollision; const convexCollision: PNewtonCollision): Pointer; cdecl; external newtondll;
procedure NewtonCompoundCollisionRemoveSubCollision (const compoundCollision: PNewtonCollision; const collisionNode: Pointer); cdecl; external newtondll;
procedure NewtonCompoundCollisionRemoveSubCollisionByIndex (const compoundCollision: PNewtonCollision; nodeIndex: Integer); cdecl; external newtondll;
procedure NewtonCompoundCollisionSetSubCollisionMatrix (const compoundCollision: PNewtonCollision; const collisionNode: Pointer; const matrix: pfloat); cdecl; external newtondll;
procedure NewtonCompoundCollisionEndAddRemove (const compoundCollision: PNewtonCollision); cdecl; external newtondll;
function NewtonCompoundCollisionGetFirstNode (const compoundCollision: PNewtonCollision): Pointer; cdecl; external newtondll;
function NewtonCompoundCollisionGetNextNode (const compoundCollision: PNewtonCollision; const collisionNode: Pointer): Pointer; cdecl; external newtondll;
function NewtonCompoundCollisionGetNodeByIndex (const compoundCollision: PNewtonCollision; index: Integer): Pointer; cdecl; external newtondll;
function NewtonCompoundCollisionGetNodeIndex (const compoundCollision: PNewtonCollision; const collisionNode: Pointer): Integer; cdecl; external newtondll;
function NewtonCompoundCollisionGetCollisionFromNode (const compoundCollision: PNewtonCollision; const collisionNode: Pointer): PNewtonCollision; cdecl; external newtondll;
{ Fractured compound collision primitives interface }
function NewtonCreateFracturedCompoundCollision (const newtonWorld: PNewtonWorld; const solidMesh: PNewtonMesh; shapeID: Integer; fracturePhysicsMaterialID: Integer; pointcloudCount: Integer; const vertexCloud: pfloat; strideInBytes: Integer; materialID: Integer; const textureMatrix: pfloat; regenerateMainMeshCallback: NewtonFractureCompoundCollisionReconstructMainMeshCallBack; emitFracturedCompound: NewtonFractureCompoundCollisionOnEmitCompoundFractured; emitFracfuredChunk: NewtonFractureCompoundCollisionOnEmitChunk): PNewtonCollision; cdecl; external newtondll;
function NewtonFracturedCompoundPlaneClip (const fracturedCompound: PNewtonCollision; const plane: pfloat): PNewtonCollision; cdecl; external newtondll;
procedure NewtonFracturedCompoundSetCallbacks (const fracturedCompound: PNewtonCollision; regenerateMainMeshCallback: NewtonFractureCompoundCollisionReconstructMainMeshCallBack; emitFracturedCompound: NewtonFractureCompoundCollisionOnEmitCompoundFractured; emitFracfuredChunk: NewtonFractureCompoundCollisionOnEmitChunk); cdecl; external newtondll;
function NewtonFracturedCompoundIsNodeFreeToDetach (const fracturedCompound: PNewtonCollision; const collisionNode: Pointer): Integer; cdecl; external newtondll;
function NewtonFracturedCompoundNeighborNodeList (const fracturedCompound: PNewtonCollision; const collisionNode: Pointer; const list: PPointer; maxCount: Integer): Integer; cdecl; external newtondll;
function NewtonFracturedCompoundGetMainMesh (const fracturedCompound: PNewtonCollision): PNewtonFracturedCompoundMeshPart; cdecl; external newtondll;
function NewtonFracturedCompoundGetFirstSubMesh (const fracturedCompound: PNewtonCollision): PNewtonFracturedCompoundMeshPart; cdecl; external newtondll;
function NewtonFracturedCompoundGetNextSubMesh (const fracturedCompound: PNewtonCollision; const subMesh: PNewtonFracturedCompoundMeshPart): PNewtonFracturedCompoundMeshPart; cdecl; external newtondll;
function NewtonFracturedCompoundCollisionGetVertexCount (const fracturedCompound: PNewtonCollision; const meshOwner: PNewtonFracturedCompoundMeshPart): Integer; cdecl; external newtondll;
function NewtonFracturedCompoundCollisionGetVertexPositions (const fracturedCompound: PNewtonCollision; const meshOwner: PNewtonFracturedCompoundMeshPart): pfloat; cdecl; external newtondll;
function NewtonFracturedCompoundCollisionGetVertexNormals (const fracturedCompound: PNewtonCollision; const meshOwner: PNewtonFracturedCompoundMeshPart): pfloat; cdecl; external newtondll;
function NewtonFracturedCompoundCollisionGetVertexUVs (const fracturedCompound: PNewtonCollision; const meshOwner: PNewtonFracturedCompoundMeshPart): pfloat; cdecl; external newtondll;
function NewtonFracturedCompoundMeshPartGetIndexStream (const fracturedCompound: PNewtonCollision; const meshOwner: PNewtonFracturedCompoundMeshPart; const segment: Pointer; const index: Pinteger): Integer; cdecl; external newtondll;
function NewtonFracturedCompoundMeshPartGetFirstSegment (const fractureCompoundMeshPart: PNewtonFracturedCompoundMeshPart): Pointer; cdecl; external newtondll;
function NewtonFracturedCompoundMeshPartGetNextSegment (const fractureCompoundMeshSegment: Pointer): Pointer; cdecl; external newtondll;
function NewtonFracturedCompoundMeshPartGetMaterial (const fractureCompoundMeshSegment: Pointer): Integer; cdecl; external newtondll;
function NewtonFracturedCompoundMeshPartGetIndexCount (const fractureCompoundMeshSegment: Pointer): Integer; cdecl; external newtondll;
{ scene collision are static compound collision that can take polygonal static collisions }
function NewtonCreateSceneCollision (const newtonWorld: PNewtonWorld; shapeID: Integer): PNewtonCollision; cdecl; external newtondll;
procedure NewtonSceneCollisionBeginAddRemove (const sceneCollision: PNewtonCollision); cdecl; external newtondll;
function NewtonSceneCollisionAddSubCollision (const sceneCollision: PNewtonCollision; const collision: PNewtonCollision): Pointer; cdecl; external newtondll;
procedure NewtonSceneCollisionRemoveSubCollision (const compoundCollision: PNewtonCollision; const collisionNode: Pointer); cdecl; external newtondll;
procedure NewtonSceneCollisionRemoveSubCollisionByIndex (const sceneCollision: PNewtonCollision; nodeIndex: Integer); cdecl; external newtondll;
procedure NewtonSceneCollisionSetSubCollisionMatrix (const sceneCollision: PNewtonCollision; const collisionNode: Pointer; const matrix: pfloat); cdecl; external newtondll;
procedure NewtonSceneCollisionEndAddRemove (const sceneCollision: PNewtonCollision); cdecl; external newtondll;
function NewtonSceneCollisionGetFirstNode (const sceneCollision: PNewtonCollision): Pointer; cdecl; external newtondll;
function NewtonSceneCollisionGetNextNode (const sceneCollision: PNewtonCollision; const collisionNode: Pointer): Pointer; cdecl; external newtondll;
function NewtonSceneCollisionGetNodeByIndex (const sceneCollision: PNewtonCollision; index: Integer): Pointer; cdecl; external newtondll;
function NewtonSceneCollisionGetNodeIndex (const sceneCollision: PNewtonCollision; const collisionNode: Pointer): Integer; cdecl; external newtondll;
function NewtonSceneCollisionGetCollisionFromNode (const sceneCollision: PNewtonCollision; const collisionNode: Pointer): PNewtonCollision; cdecl; external newtondll;
{ User Static mesh collision interface }
function NewtonCreateUserMeshCollision (const newtonWorld: PNewtonWorld; const minBox: pfloat; const maxBox: pfloat; const userData: Pointer; collideCallback: NewtonUserMeshCollisionCollideCallback; rayHitCallback: NewtonUserMeshCollisionRayHitCallback; destroyCallback: NewtonUserMeshCollisionDestroyCallback; getInfoCallback: NewtonUserMeshCollisionGetCollisionInfo; getLocalAABBCallback: NewtonUserMeshCollisionAABBTest; facesInAABBCallback: NewtonUserMeshCollisionGetFacesInAABB; serializeCallback: NewtonOnUserCollisionSerializationCallback; shapeID: Integer): PNewtonCollision; cdecl; external newtondll;
function NewtonUserMeshCollisionContinuousOverlapTest (const collideDescData: PNewtonUserMeshCollisionCollideDesc; const continueCollisionHandle: Pointer; const minAabb: pfloat; const maxAabb: pfloat): Integer; cdecl; external newtondll;
{ Collision serialization functions }
function NewtonCreateCollisionFromSerialization (const newtonWorld: PNewtonWorld; deserializeFunction: NewtonDeserializeCallback; const serializeHandle: Pointer): PNewtonCollision; cdecl; external newtondll;
procedure NewtonCollisionSerialize (const newtonWorld: PNewtonWorld; const collision: PNewtonCollision; serializeFunction: NewtonSerializeCallback; const serializeHandle: Pointer); cdecl; external newtondll;
procedure NewtonCollisionGetInfo (const collision: PNewtonCollision; const collisionInfo: PNewtonCollisionInfoRecord); cdecl; external newtondll;
{ Static collision shapes functions }
function NewtonCreateHeightFieldCollision (const newtonWorld: PNewtonWorld; width: Integer; height: Integer; gridsDiagonals: Integer; elevationdatType: Integer; const elevationMap: Pointer; const attributeMap: pchar; verticalScale: dfloat; horizontalScale_x: dfloat; horizontalScale_z: dfloat; shapeID: Integer): PNewtonCollision; cdecl; external newtondll;
procedure NewtonHeightFieldSetUserRayCastCallback (const heightfieldCollision: PNewtonCollision; rayHitCallback: NewtonHeightFieldRayCastCallback); cdecl; external newtondll;
procedure NewtonHeightFieldSetHorizontalDisplacement (const heightfieldCollision: PNewtonCollision; const horizontalMap: LongWord; scale: dfloat); cdecl; external newtondll;
function NewtonCreateTreeCollision (const newtonWorld: PNewtonWorld; shapeID: Integer): PNewtonCollision; cdecl; external newtondll;
function NewtonCreateTreeCollisionFromMesh (const newtonWorld: PNewtonWorld; const mesh: PNewtonMesh; shapeID: Integer): PNewtonCollision; cdecl; external newtondll;
procedure NewtonTreeCollisionSetUserRayCastCallback (const treeCollision: PNewtonCollision; rayHitCallback: NewtonCollisionTreeRayCastCallback); cdecl; external newtondll;
procedure NewtonTreeCollisionBeginBuild (const treeCollision: PNewtonCollision); cdecl; external newtondll;
procedure NewtonTreeCollisionAddFace (const treeCollision: PNewtonCollision; vertexCount: Integer; const vertexPtr: pfloat; strideInBytes: Integer; faceAttribute: Integer); cdecl; external newtondll;
procedure NewtonTreeCollisionEndBuild (const treeCollision: PNewtonCollision; optimize: Integer); cdecl; external newtondll;
function NewtonTreeCollisionGetFaceAttribute (const treeCollision: PNewtonCollision; const faceIndexArray: Pinteger; indexCount: Integer): Integer; cdecl; external newtondll;
procedure NewtonTreeCollisionSetFaceAttribute (const treeCollision: PNewtonCollision; const faceIndexArray: Pinteger; indexCount: Integer; attribute: Integer); cdecl; external newtondll;
procedure NewtonTreeCollisionForEachFace (const treeCollision: PNewtonCollision; forEachFaceCallback: NewtonTreeCollisionFaceCallback; const context: Pointer); cdecl; external newtondll;
function NewtonTreeCollisionGetVertexListTriangleListInAABB (const treeCollision: PNewtonCollision; const p0: pfloat; const p1: pfloat; const vertexArray: Pfloat; const vertexCount: Pinteger; const vertexStrideInBytes: Pinteger; const indexList: Pinteger; maxIndexCount: Integer; const faceAttribute: Pinteger): Integer; cdecl; external newtondll;
procedure NewtonStaticCollisionSetDebugCallback (const staticCollision: PNewtonCollision; userCallback: NewtonTreeCollisionCallback); cdecl; external newtondll;
{ General purpose collision library functions }
function NewtonCollisionCreateInstance (const collision: PNewtonCollision): PNewtonCollision; cdecl; external newtondll;
function NewtonCollisionGetType (const collision: PNewtonCollision): Integer; cdecl; external newtondll;
function NewtonCollisionIsConvexShape (const collision: PNewtonCollision): Integer; cdecl; external newtondll;
function NewtonCollisionIsStaticShape (const collision: PNewtonCollision): Integer; cdecl; external newtondll;
procedure NewtonCollisionSetUserData (const collision: PNewtonCollision; const userData: Pointer); cdecl; external newtondll;
function NewtonCollisionGetUserData (const collision: PNewtonCollision): Pointer; cdecl; external newtondll;
procedure NewtonCollisionSetUserID (const collision: PNewtonCollision; id: LongWord); cdecl; external newtondll;
function NewtonCollisionGetUserID (const collision: PNewtonCollision): LongWord; cdecl; external newtondll;
procedure NewtonCollisionGetMaterial (const collision: PNewtonCollision; const userData: PNewtonCollisionMaterial); cdecl; external newtondll;
procedure NewtonCollisionSetMaterial (const collision: PNewtonCollision; const userData: PNewtonCollisionMaterial); cdecl; external newtondll;
function NewtonCollisionGetSubCollisionHandle (const collision: PNewtonCollision): Pointer; cdecl; external newtondll;
function NewtonCollisionGetParentInstance (const collision: PNewtonCollision): PNewtonCollision; cdecl; external newtondll;
procedure NewtonCollisionSetMatrix (const collision: PNewtonCollision; const matrix: pfloat); cdecl; external newtondll;
procedure NewtonCollisionGetMatrix (const collision: PNewtonCollision; const matrix: pfloat); cdecl; external newtondll;
procedure NewtonCollisionSetScale (const collision: PNewtonCollision; scaleX: dfloat; scaleY: dfloat; scaleZ: dfloat); cdecl; external newtondll;
procedure NewtonCollisionGetScale (const collision: PNewtonCollision; const scaleX: pfloat; const scaleY: pfloat; const scaleZ: pfloat); cdecl; external newtondll;
procedure NewtonDestroyCollision (const collision: PNewtonCollision); cdecl; external newtondll;
function NewtonCollisionGetSkinThickness (const collision: PNewtonCollision): dfloat; cdecl; external newtondll;
procedure NewtonCollisionSetSkinThickness (const collision: PNewtonCollision; thickness: dfloat); cdecl; external newtondll;
function NewtonCollisionIntersectionTest (const newtonWorld: PNewtonWorld; const collisionA: PNewtonCollision; const matrixA: pfloat; const collisionB: PNewtonCollision; const matrixB: pfloat; threadIndex: Integer): Integer; cdecl; external newtondll;
function NewtonCollisionPointDistance (const newtonWorld: PNewtonWorld; const point: pfloat; const collision: PNewtonCollision; const matrix: pfloat; const contact: pfloat; const normal: pfloat; threadIndex: Integer): Integer; cdecl; external newtondll;
function NewtonCollisionClosestPoint (const newtonWorld: PNewtonWorld; const collisionA: PNewtonCollision; const matrixA: pfloat; const collisionB: PNewtonCollision; const matrixB: pfloat; const contactA: pfloat; const contactB: pfloat; const normalAB: pfloat; threadIndex: Integer): Integer; cdecl; external newtondll;
function NewtonCollisionCollide (const newtonWorld: PNewtonWorld; maxSize: Integer; const collisionA: PNewtonCollision; const matrixA: pfloat; const collisionB: PNewtonCollision; const matrixB: pfloat; const contacts: pfloat; const normals: pfloat; const penetration: pfloat; const attributeA: Pint64; const attributeB: Pint64; threadIndex: Integer): Integer; cdecl; external newtondll;
function NewtonCollisionCollideContinue (const newtonWorld: PNewtonWorld; maxSize: Integer; timestep: dfloat; const collisionA: PNewtonCollision; const matrixA: pfloat; const velocA: pfloat; const omegaA: pfloat; const collisionB: PNewtonCollision; const matrixB: pfloat; const velocB: pfloat; const omegaB: pfloat; const timeOfImpact: pfloat; const contacts: pfloat; const normals: pfloat; const penetration: pfloat; const attributeA: Pint64; const attributeB: Pint64; threadIndex: Integer): Integer; cdecl; external newtondll;
procedure NewtonCollisionSupportVertex (const collision: PNewtonCollision; const dir: pfloat; const vertex: pfloat); cdecl; external newtondll;
function NewtonCollisionRayCast (const collision: PNewtonCollision; const p0: pfloat; const p1: pfloat; const normal: pfloat; const attribute: Pint64): dfloat; cdecl; external newtondll;
procedure NewtonCollisionCalculateAABB (const collision: PNewtonCollision; const matrix: pfloat; const p0: pfloat; const p1: pfloat); cdecl; external newtondll;
procedure NewtonCollisionForEachPolygonDo (const collision: PNewtonCollision; const matrix: pfloat; callback: NewtonCollisionIterator; const userData: Pointer); cdecl; external newtondll;
{ collision aggregates, are a collision node on eh broad phase the serve as the root nod for a collection of rigid bodies
	  that shared the property of being in close proximity all the time, they are similar to compound collision by the group bodies instead of collision instances
	  These are good for speeding calculation calculation of rag doll, Vehicles or contractions of rigid bodied lined by joints.
	  also for example if you know that many the life time of a group of bodies like the object on a house of a building will be localize to the confide of the building
	  then warping the bodies under an aggregate will reduce collision calculation of almost an order of magnitude. }
function NewtonCollisionAggregateCreate (const world: PNewtonWorld): Pointer; cdecl; external newtondll;
procedure NewtonCollisionAggregateDestroy (const aggregate: Pointer); cdecl; external newtondll;
procedure NewtonCollisionAggregateAddBody (const aggregate: Pointer; const body: pNewtonBody); cdecl; external newtondll;
procedure NewtonCollisionAggregateRemoveBody (const aggregate: Pointer; const body: pNewtonBody); cdecl; external newtondll;
function NewtonCollisionAggregateGetSelfCollision (const aggregate: Pointer): Integer; cdecl; external newtondll;
procedure NewtonCollisionAggregateSetSelfCollision (const aggregate: Pointer; state: Integer); cdecl; external newtondll;
{ transforms utility functions }
procedure NewtonSetEulerAngle (const eulersAngles: pfloat; const matrix: pfloat); cdecl; external newtondll;
procedure NewtonGetEulerAngle (const matrix: pfloat; const eulersAngles0: pfloat; const eulersAngles1: pfloat); cdecl; external newtondll;
function NewtonCalculateSpringDamperAcceleration (dt: dfloat; ks: dfloat; x: dfloat; kd: dfloat; s: dfloat): dfloat; cdecl; external newtondll;
{ body manipulation functions }
function NewtonCreateDynamicBody (const newtonWorld: PNewtonWorld; const collision: PNewtonCollision; const matrix: pfloat): pNewtonBody; cdecl; external newtondll;
function NewtonCreateKinematicBody (const newtonWorld: PNewtonWorld; const collision: PNewtonCollision; const matrix: pfloat): pNewtonBody; cdecl; external newtondll;
function NewtonCreateAsymetricDynamicBody (const newtonWorld: PNewtonWorld; const collision: PNewtonCollision; const matrix: pfloat): pNewtonBody; cdecl; external newtondll;
procedure NewtonDestroyBody (const body: pNewtonBody); cdecl; external newtondll;
function NewtonBodyGetSimulationState (const body: pNewtonBody): Integer; cdecl; external newtondll;
procedure NewtonBodySetSimulationState (const bodyPtr: pNewtonBody; const state: Integer); cdecl; external newtondll;
function NewtonBodyGetType (const body: pNewtonBody): Integer; cdecl; external newtondll;
function NewtonBodyGetCollidable (const body: pNewtonBody): Integer; cdecl; external newtondll;
procedure NewtonBodySetCollidable (const body: pNewtonBody; collidableState: Integer); cdecl; external newtondll;
procedure NewtonBodyAddForce (const body: pNewtonBody; const force: pfloat); cdecl; external newtondll;
procedure NewtonBodyAddTorque (const body: pNewtonBody; const torque: pfloat); cdecl; external newtondll;
procedure NewtonBodyCalculateInverseDynamicsForce (const body: pNewtonBody; timestep: dfloat; const desiredVeloc: pfloat; const forceOut: pfloat); cdecl; external newtondll;
procedure NewtonBodySetCentreOfMass (const body: pNewtonBody; const com: pfloat); cdecl; external newtondll;
procedure NewtonBodySetMassMatrix (const body: pNewtonBody; mass: dfloat; Ixx: dfloat; Iyy: dfloat; Izz: dfloat); cdecl; external newtondll;
procedure NewtonBodySetFullMassMatrix (const body: pNewtonBody; mass: dfloat; const inertiaMatrix: pfloat); cdecl; external newtondll;
procedure NewtonBodySetMassProperties (const body: pNewtonBody; mass: dfloat; const collision: PNewtonCollision); cdecl; external newtondll;
procedure NewtonBodySetMatrix (const body: pNewtonBody; const matrix: pfloat); cdecl; external newtondll;
procedure NewtonBodySetMatrixNoSleep (const body: pNewtonBody; const matrix: pfloat); cdecl; external newtondll;
procedure NewtonBodySetMatrixRecursive (const body: pNewtonBody; const matrix: pfloat); cdecl; external newtondll;
procedure NewtonBodySetMaterialGroupID (const body: pNewtonBody; id: Integer); cdecl; external newtondll;
procedure NewtonBodySetContinuousCollisionMode (const body: pNewtonBody; state: LongWord); cdecl; external newtondll;
procedure NewtonBodySetJointRecursiveCollision (const body: pNewtonBody; state: LongWord); cdecl; external newtondll;
procedure NewtonBodySetOmega (const body: pNewtonBody; const omega: pfloat); cdecl; external newtondll;
procedure NewtonBodySetOmegaNoSleep (const body: pNewtonBody; const omega: pfloat); cdecl; external newtondll;
procedure NewtonBodySetVelocity (const body: pNewtonBody; const velocity: pfloat); cdecl; external newtondll;
procedure NewtonBodySetVelocityNoSleep (const body: pNewtonBody; const velocity: pfloat); cdecl; external newtondll;
procedure NewtonBodySetForce (const body: pNewtonBody; const force: pfloat); cdecl; external newtondll;
procedure NewtonBodySetTorque (const body: pNewtonBody; const torque: pfloat); cdecl; external newtondll;
procedure NewtonBodySetLinearDamping (const body: pNewtonBody; linearDamp: dfloat); cdecl; external newtondll;
procedure NewtonBodySetAngularDamping (const body: pNewtonBody; const angularDamp: pfloat); cdecl; external newtondll;
procedure NewtonBodySetCollision (const body: pNewtonBody; const collision: PNewtonCollision); cdecl; external newtondll;
procedure NewtonBodySetCollisionScale (const body: pNewtonBody; scaleX: dfloat; scaleY: dfloat; scaleZ: dfloat); cdecl; external newtondll;
function NewtonBodyGetSleepState (const body: pNewtonBody): Integer; cdecl; external newtondll;
procedure NewtonBodySetSleepState (const body: pNewtonBody; state: Integer); cdecl; external newtondll;
function NewtonBodyGetAutoSleep (const body: pNewtonBody): Integer; cdecl; external newtondll;
procedure NewtonBodySetAutoSleep (const body: pNewtonBody; state: Integer); cdecl; external newtondll;
function NewtonBodyGetFreezeState (const body: pNewtonBody): Integer; cdecl; external newtondll;
procedure NewtonBodySetFreezeState (const body: pNewtonBody; state: Integer); cdecl; external newtondll;
function NewtonBodyGetGyroscopicTorque (const body: pNewtonBody): Integer; cdecl; external newtondll;
procedure NewtonBodySetGyroscopicTorque (const body: pNewtonBody; state: Integer); cdecl; external newtondll;
procedure NewtonBodySetDestructorCallback (const body: pNewtonBody; callback: NewtonBodyDestructor); cdecl; external newtondll;
function NewtonBodyGetDestructorCallback (const body: pNewtonBody): PNewtonBodyDestructor; cdecl; external newtondll;
procedure NewtonBodySetTransformCallback (const body: pNewtonBody; callback: NewtonSetTransform); cdecl; external newtondll;
function NewtonBodyGetTransformCallback (const body: pNewtonBody): PNewtonSetTransform; cdecl; external newtondll;
procedure NewtonBodySetForceAndTorqueCallback (const body: pNewtonBody; callback: NewtonApplyForceAndTorque); cdecl; external newtondll;
function NewtonBodyGetForceAndTorqueCallback (const body: pNewtonBody): PNewtonApplyForceAndTorque; cdecl; external newtondll;
function NewtonBodyGetID (const body: pNewtonBody): Integer; cdecl; external newtondll;
procedure NewtonBodySetUserData (const body: pNewtonBody; const userData: Pointer); cdecl; external newtondll;
function NewtonBodyGetUserData (const body: pNewtonBody): Pointer; cdecl; external newtondll;
function NewtonBodyGetWorld (const body: pNewtonBody): PNewtonWorld; cdecl; external newtondll;
function NewtonBodyGetCollision (const body: pNewtonBody): PNewtonCollision; cdecl; external newtondll;
function NewtonBodyGetMaterialGroupID (const body: pNewtonBody): Integer; cdecl; external newtondll;
function NewtonBodyGetSerializedID (const body: pNewtonBody): Integer; cdecl; external newtondll;
function NewtonBodyGetContinuousCollisionMode (const body: pNewtonBody): Integer; cdecl; external newtondll;
function NewtonBodyGetJointRecursiveCollision (const body: pNewtonBody): Integer; cdecl; external newtondll;
procedure NewtonBodyGetPosition (const body: pNewtonBody; const pos: pfloat); cdecl; external newtondll;
procedure NewtonBodyGetMatrix (const body: pNewtonBody; const matrix: pfloat); cdecl; external newtondll;
procedure NewtonBodyGetRotation (const body: pNewtonBody; const rotation: pfloat); cdecl; external newtondll;
procedure NewtonBodyGetMass (const body: pNewtonBody; mass: pfloat; const Ixx: pfloat; const Iyy: pfloat; const Izz: pfloat); cdecl; external newtondll;
procedure NewtonBodyGetInvMass (const body: pNewtonBody; const invMass: pfloat; const invIxx: pfloat; const invIyy: pfloat; const invIzz: pfloat); cdecl; external newtondll;
procedure NewtonBodyGetInertiaMatrix (const body: pNewtonBody; const inertiaMatrix: pfloat); cdecl; external newtondll;
procedure NewtonBodyGetInvInertiaMatrix (const body: pNewtonBody; const invInertiaMatrix: pfloat); cdecl; external newtondll;
procedure NewtonBodyGetOmega (const body: pNewtonBody; const vector: pfloat); cdecl; external newtondll;
procedure NewtonBodyGetVelocity (const body: pNewtonBody; const vector: pfloat); cdecl; external newtondll;
procedure NewtonBodyGetAlpha (const body: pNewtonBody; const vector: pfloat); cdecl; external newtondll;
procedure NewtonBodyGetAcceleration (const body: pNewtonBody; const vector: pfloat); cdecl; external newtondll;
procedure NewtonBodyGetForce (const body: pNewtonBody; const vector: pfloat); cdecl; external newtondll;
procedure NewtonBodyGetTorque (const body: pNewtonBody; const vector: pfloat); cdecl; external newtondll;
procedure NewtonBodyGetCentreOfMass (const body: pNewtonBody; const com: pfloat); cdecl; external newtondll;
procedure NewtonBodyGetPointVelocity (const body: pNewtonBody; const point: pfloat; const velocOut: pfloat); cdecl; external newtondll;
procedure NewtonBodyApplyImpulsePair (const body: pNewtonBody; const linearImpulse: pfloat; const angularImpulse: pfloat; timestep: dfloat); cdecl; external newtondll;
procedure NewtonBodyAddImpulse (const body: pNewtonBody; const pointDeltaVeloc: pfloat; const pointPosit: pfloat; timestep: dfloat); cdecl; external newtondll;
procedure NewtonBodyApplyImpulseArray (const body: pNewtonBody; impuleCount: Integer; strideInByte: Integer; const impulseArray: pfloat; const pointArray: pfloat; timestep: dfloat); cdecl; external newtondll;
procedure NewtonBodyIntegrateVelocity (const body: pNewtonBody; timestep: dfloat); cdecl; external newtondll;
function NewtonBodyGetLinearDamping (const body: pNewtonBody): dfloat; cdecl; external newtondll;
procedure NewtonBodyGetAngularDamping (const body: pNewtonBody; const vector: pfloat); cdecl; external newtondll;
procedure NewtonBodyGetAABB (const body: pNewtonBody; const p0: pfloat; const p1: pfloat); cdecl; external newtondll;
function NewtonBodyGetFirstJoint (const body: pNewtonBody): PNewtonJoint; cdecl; external newtondll;
function NewtonBodyGetNextJoint (const body: pNewtonBody; const joint: PNewtonJoint): PNewtonJoint; cdecl; external newtondll;
function NewtonBodyGetFirstContactJoint (const body: pNewtonBody): PNewtonJoint; cdecl; external newtondll;
function NewtonBodyGetNextContactJoint (const body: pNewtonBody; const contactJoint: PNewtonJoint): PNewtonJoint; cdecl; external newtondll;
function NewtonBodyFindContact (const body0: pNewtonBody; const body1: pNewtonBody): PNewtonJoint; cdecl; external newtondll;
{ contact joints interface }
function NewtonContactJointGetFirstContact (const contactJoint: PNewtonJoint): Pointer; cdecl; external newtondll;
function NewtonContactJointGetNextContact (const contactJoint: PNewtonJoint; const contact: Pointer): Pointer; cdecl; external newtondll;
function NewtonContactJointGetContactCount (const contactJoint: PNewtonJoint): Integer; cdecl; external newtondll;
procedure NewtonContactJointRemoveContact (const contactJoint: PNewtonJoint; const contact: Pointer); cdecl; external newtondll;
function NewtonContactJointGetClosestDistance (const contactJoint: PNewtonJoint): dfloat; cdecl; external newtondll;
procedure NewtonContactJointResetSelftJointCollision (const contactJoint: PNewtonJoint); cdecl; external newtondll;
procedure NewtonContactJointResetIntraJointCollision (const contactJoint: PNewtonJoint); cdecl; external newtondll;
function NewtonContactGetMaterial (const contact: Pointer): PNewtonMaterial; cdecl; external newtondll;
function NewtonContactGetCollision0 (const contact: Pointer): PNewtonCollision; cdecl; external newtondll;
function NewtonContactGetCollision1 (const contact: Pointer): PNewtonCollision; cdecl; external newtondll;
function NewtonContactGetCollisionID0 (const contact: Pointer): Pointer; cdecl; external newtondll;
function NewtonContactGetCollisionID1 (const contact: Pointer): Pointer; cdecl; external newtondll;
{ Common joint functions }
function NewtonJointGetUserData (const joint: PNewtonJoint): Pointer; cdecl; external newtondll;
procedure NewtonJointSetUserData (const joint: PNewtonJoint; const userData: Pointer); cdecl; external newtondll;
function NewtonJointGetBody0 (const joint: PNewtonJoint): pNewtonBody; cdecl; external newtondll;
function NewtonJointGetBody1 (const joint: PNewtonJoint): pNewtonBody; cdecl; external newtondll;
procedure NewtonJointGetInfo (const joint: PNewtonJoint; const info: PNewtonJointRecord); cdecl; external newtondll;
function NewtonJointGetCollisionState (const joint: PNewtonJoint): Integer; cdecl; external newtondll;
procedure NewtonJointSetCollisionState (const joint: PNewtonJoint; state: Integer); cdecl; external newtondll;
function NewtonJointGetStiffness (const joint: PNewtonJoint): dfloat; cdecl; external newtondll;
procedure NewtonJointSetStiffness (const joint: PNewtonJoint; state: dfloat); cdecl; external newtondll;
procedure NewtonDestroyJoint (const newtonWorld: PNewtonWorld; const joint: PNewtonJoint); cdecl; external newtondll;
procedure NewtonJointSetDestructor (const joint: PNewtonJoint; destructorparam: NewtonConstraintDestructor); cdecl; external newtondll;
function NewtonJointIsActive (const joint: PNewtonJoint): Integer; cdecl; external newtondll;
{ InverseDynamics Interface }
function NewtonCreateInverseDynamics (const newtonWorld: PNewtonWorld): PNewtonInverseDynamics; cdecl; external newtondll;
procedure NewtonInverseDynamicsDestroy (const inverseDynamics: PNewtonInverseDynamics); cdecl; external newtondll;
function NewtonInverseDynamicsGetRoot (const inverseDynamics: PNewtonInverseDynamics): Pointer; cdecl; external newtondll;
function NewtonInverseDynamicsGetNextChildNode (const inverseDynamics: PNewtonInverseDynamics; const node: Pointer): Pointer; cdecl; external newtondll;
function NewtonInverseDynamicsGetFirstChildNode (const inverseDynamics: PNewtonInverseDynamics; const parentNode: Pointer): Pointer; cdecl; external newtondll;
function NewtonInverseDynamicsGetBody (const inverseDynamics: PNewtonInverseDynamics; const node: Pointer): pNewtonBody; cdecl; external newtondll;
function NewtonInverseDynamicsGetJoint (const inverseDynamics: PNewtonInverseDynamics; const node: Pointer): PNewtonJoint; cdecl; external newtondll;
function NewtonInverseDynamicsCreateEffector (const inverseDynamics: PNewtonInverseDynamics; const node: Pointer; callback: NewtonUserBilateralCallback): PNewtonJoint; cdecl; external newtondll;
procedure NewtonInverseDynamicsDestroyEffector (const effector: PNewtonJoint); cdecl; external newtondll;
function NewtonInverseDynamicsAddRoot (const inverseDynamics: PNewtonInverseDynamics; const root: pNewtonBody): Pointer; cdecl; external newtondll;
function NewtonInverseDynamicsAddChildNode (const inverseDynamics: PNewtonInverseDynamics; const parentNode: Pointer; const joint: PNewtonJoint): Pointer; cdecl; external newtondll;
function NewtonInverseDynamicsAddLoopJoint (const inverseDynamics: PNewtonInverseDynamics; const joint: PNewtonJoint): Boolean; cdecl; external newtondll;
procedure NewtonInverseDynamicsEndBuild (const inverseDynamics: PNewtonInverseDynamics); cdecl; external newtondll;
procedure NewtonInverseDynamicsUpdate (const inverseDynamics: PNewtonInverseDynamics; timestep: dfloat; threadIndex: Integer); cdecl; external newtondll;
{ particle system interface (soft bodies, individual, pressure bodies and cloth) }
function NewtonCreateMassSpringDamperSystem (const newtonWorld: PNewtonWorld; shapeID: Integer; const points: pfloat; pointCount: Integer; strideInBytes: Integer; const pointMass: pfloat; const links: Pinteger; linksCount: Integer; const linksSpring: pfloat; const linksDamper: pfloat): PNewtonCollision; cdecl; external newtondll;
function NewtonCreateDeformableSolid (const newtonWorld: PNewtonWorld; const mesh: PNewtonMesh; shapeID: Integer): PNewtonCollision; cdecl; external newtondll;
function NewtonDeformableMeshGetParticleCount (const deformableMesh: PNewtonCollision): Integer; cdecl; external newtondll;
function NewtonDeformableMeshGetParticleStrideInBytes (const deformableMesh: PNewtonCollision): Integer; cdecl; external newtondll;
function NewtonDeformableMeshGetParticleArray (const deformableMesh: PNewtonCollision): pfloat; cdecl; external newtondll;
{ Ball and Socket joint functions }
function NewtonConstraintCreateBall (const newtonWorld: PNewtonWorld; const pivotPoint: pfloat; const childBody: pNewtonBody; const parentBody: pNewtonBody): PNewtonJoint; cdecl; external newtondll;
procedure NewtonBallSetUserCallback (const ball: PNewtonJoint; callback: NewtonBallCallback); cdecl; external newtondll;
procedure NewtonBallGetJointAngle (const ball: PNewtonJoint; angle: pfloat); cdecl; external newtondll;
procedure NewtonBallGetJointOmega (const ball: PNewtonJoint; omega: pfloat); cdecl; external newtondll;
procedure NewtonBallGetJointForce (const ball: PNewtonJoint; const force: pfloat); cdecl; external newtondll;
procedure NewtonBallSetConeLimits (const ball: PNewtonJoint; const pin: pfloat; maxConeAngle: dfloat; maxTwistAngle: dfloat); cdecl; external newtondll;
{ Hinge joint functions }
function NewtonConstraintCreateHinge (const newtonWorld: PNewtonWorld; const pivotPoint: pfloat; const pinDir: pfloat; const childBody: pNewtonBody; const parentBody: pNewtonBody): PNewtonJoint; cdecl; external newtondll;
procedure NewtonHingeSetUserCallback (const hinge: PNewtonJoint; callback: NewtonHingeCallback); cdecl; external newtondll;
function NewtonHingeGetJointAngle (const hinge: PNewtonJoint): dfloat; cdecl; external newtondll;
function NewtonHingeGetJointOmega (const hinge: PNewtonJoint): dfloat; cdecl; external newtondll;
procedure NewtonHingeGetJointForce (const hinge: PNewtonJoint; const force: pfloat); cdecl; external newtondll;
function NewtonHingeCalculateStopAlpha (const hinge: PNewtonJoint; const desc: PNewtonHingeSliderUpdateDesc; angle: dfloat): dfloat; cdecl; external newtondll;
{ Slider joint functions }
function NewtonConstraintCreateSlider (const newtonWorld: PNewtonWorld; const pivotPoint: pfloat; const pinDir: pfloat; const childBody: pNewtonBody; const parentBody: pNewtonBody): PNewtonJoint; cdecl; external newtondll;
procedure NewtonSliderSetUserCallback (const slider: PNewtonJoint; callback: NewtonSliderCallback); cdecl; external newtondll;
function NewtonSliderGetJointPosit (const slider: PNewtonJoint): dfloat; cdecl; external newtondll;
function NewtonSliderGetJointVeloc (const slider: PNewtonJoint): dfloat; cdecl; external newtondll;
procedure NewtonSliderGetJointForce (const slider: PNewtonJoint; const force: pfloat); cdecl; external newtondll;
function NewtonSliderCalculateStopAccel (const slider: PNewtonJoint; const desc: PNewtonHingeSliderUpdateDesc; position: dfloat): dfloat; cdecl; external newtondll;
{ Corkscrew joint functions }
function NewtonConstraintCreateCorkscrew (const newtonWorld: PNewtonWorld; const pivotPoint: pfloat; const pinDir: pfloat; const childBody: pNewtonBody; const parentBody: pNewtonBody): PNewtonJoint; cdecl; external newtondll;
procedure NewtonCorkscrewSetUserCallback (const corkscrew: PNewtonJoint; callback: NewtonCorkscrewCallback); cdecl; external newtondll;
function NewtonCorkscrewGetJointPosit (const corkscrew: PNewtonJoint): dfloat; cdecl; external newtondll;
function NewtonCorkscrewGetJointAngle (const corkscrew: PNewtonJoint): dfloat; cdecl; external newtondll;
function NewtonCorkscrewGetJointVeloc (const corkscrew: PNewtonJoint): dfloat; cdecl; external newtondll;
function NewtonCorkscrewGetJointOmega (const corkscrew: PNewtonJoint): dfloat; cdecl; external newtondll;
procedure NewtonCorkscrewGetJointForce (const corkscrew: PNewtonJoint; const force: pfloat); cdecl; external newtondll;
function NewtonCorkscrewCalculateStopAlpha (const corkscrew: PNewtonJoint; const desc: PNewtonHingeSliderUpdateDesc; angle: dfloat): dfloat; cdecl; external newtondll;
function NewtonCorkscrewCalculateStopAccel (const corkscrew: PNewtonJoint; const desc: PNewtonHingeSliderUpdateDesc; position: dfloat): dfloat; cdecl; external newtondll;
{ Universal joint functions }
function NewtonConstraintCreateUniversal (const newtonWorld: PNewtonWorld; const pivotPoint: pfloat; const pinDir0: pfloat; const pinDir1: pfloat; const childBody: pNewtonBody; const parentBody: pNewtonBody): PNewtonJoint; cdecl; external newtondll;
procedure NewtonUniversalSetUserCallback (const universal: PNewtonJoint; callback: NewtonUniversalCallback); cdecl; external newtondll;
function NewtonUniversalGetJointAngle0 (const universal: PNewtonJoint): dfloat; cdecl; external newtondll;
function NewtonUniversalGetJointAngle1 (const universal: PNewtonJoint): dfloat; cdecl; external newtondll;
function NewtonUniversalGetJointOmega0 (const universal: PNewtonJoint): dfloat; cdecl; external newtondll;
function NewtonUniversalGetJointOmega1 (const universal: PNewtonJoint): dfloat; cdecl; external newtondll;
procedure NewtonUniversalGetJointForce (const universal: PNewtonJoint; const force: pfloat); cdecl; external newtondll;
function NewtonUniversalCalculateStopAlpha0 (const universal: PNewtonJoint; const desc: PNewtonHingeSliderUpdateDesc; angle: dfloat): dfloat; cdecl; external newtondll;
function NewtonUniversalCalculateStopAlpha1 (const universal: PNewtonJoint; const desc: PNewtonHingeSliderUpdateDesc; angle: dfloat): dfloat; cdecl; external newtondll;
{ Up vector joint functions }
function NewtonConstraintCreateUpVector (const newtonWorld: PNewtonWorld; const pinDir: pfloat; const body: pNewtonBody): PNewtonJoint; cdecl; external newtondll;
procedure NewtonUpVectorGetPin (const upVector: PNewtonJoint; pin: dfloat); cdecl; external newtondll;
procedure NewtonUpVectorSetPin (const upVector: PNewtonJoint; const pin: dfloat); cdecl; external newtondll;
{ User defined bilateral Joint }
function NewtonConstraintCreateUserJoint (const newtonWorld: PNewtonWorld; maxDOF: Integer; callback: NewtonUserBilateralCallback; const childBody: pNewtonBody; const parentBody: pNewtonBody): PNewtonJoint; cdecl; external newtondll;
function NewtonUserJointGetSolverModel (const joint: PNewtonJoint): Integer; cdecl; external newtondll;
procedure NewtonUserJointSetSolverModel (const joint: PNewtonJoint; model: Integer); cdecl; external newtondll;
procedure NewtonUserJointSetFeedbackCollectorCallback (const joint: PNewtonJoint; getFeedback: NewtonUserBilateralCallback); cdecl; external newtondll;
procedure NewtonUserJointAddLinearRow (const joint: PNewtonJoint; const pivot0: pfloat; const pivot1: pfloat; const dir: pfloat); cdecl; external newtondll;
procedure NewtonUserJointAddAngularRow (const joint: PNewtonJoint; relativeAngle: dfloat; const dir: pfloat); cdecl; external newtondll;
procedure NewtonUserJointAddGeneralRow (const joint: PNewtonJoint; const jacobian0: pfloat; const jacobian1: pfloat); cdecl; external newtondll;
procedure NewtonUserJointSetRowMinimumFriction (const joint: PNewtonJoint; friction: dfloat); cdecl; external newtondll;
procedure NewtonUserJointSetRowMaximumFriction (const joint: PNewtonJoint; friction: dfloat); cdecl; external newtondll;
function NewtonUserJointCalculateRowZeroAcceleration (const joint: PNewtonJoint): dfloat; cdecl; external newtondll;
function NewtonUserJointGetRowAcceleration (const joint: PNewtonJoint): dfloat; cdecl; external newtondll;
procedure NewtonUserJointSetRowAsInverseDynamics (const joint: PNewtonJoint); cdecl; external newtondll;
procedure NewtonUserJointSetRowAcceleration (const joint: PNewtonJoint; acceleration: dfloat); cdecl; external newtondll;
procedure NewtonUserJointSetRowSpringDamperAcceleration (const joint: PNewtonJoint; rowStiffness: dfloat; spring: dfloat; damper: dfloat); cdecl; external newtondll;
procedure NewtonUserJointSetRowStiffness (const joint: PNewtonJoint; stiffness: dfloat); cdecl; external newtondll;
function NewtonUserJoinRowsCount (const joint: PNewtonJoint): Integer; cdecl; external newtondll;
procedure NewtonUserJointGetGeneralRow (const joint: PNewtonJoint; index: Integer; const jacobian0: pfloat; const jacobian1: pfloat); cdecl; external newtondll;
function NewtonUserJointGetRowForce (const joint: PNewtonJoint; row: Integer): dfloat; cdecl; external newtondll;
function NewtonUserJointSubmitImmediateModeConstraint (const joint: PNewtonJoint; const descriptor: PNewtonImmediateModeConstraint; timestep: dfloat): Integer; cdecl; external newtondll;
{ Mesh joint functions }
function NewtonMeshCreate (const newtonWorld: PNewtonWorld): PNewtonMesh; cdecl; external newtondll;
function NewtonMeshCreateFromMesh (const mesh: PNewtonMesh): PNewtonMesh; cdecl; external newtondll;
function NewtonMeshCreateFromCollision (const collision: PNewtonCollision): PNewtonMesh; cdecl; external newtondll;
function NewtonMeshCreateTetrahedraIsoSurface (const mesh: PNewtonMesh): PNewtonMesh; cdecl; external newtondll;
function NewtonMeshCreateConvexHull (const newtonWorld: PNewtonWorld; pointCount: Integer; const vertexCloud: pfloat; strideInBytes: Integer; tolerance: dfloat): PNewtonMesh; cdecl; external newtondll;
function NewtonMeshCreateVoronoiConvexDecomposition (const newtonWorld: PNewtonWorld; pointCount: Integer; const vertexCloud: pfloat; strideInBytes: Integer; materialID: Integer; const textureMatrix: pfloat): PNewtonMesh; cdecl; external newtondll;
function NewtonMeshCreateFromSerialization (const newtonWorld: PNewtonWorld; deserializeFunction: NewtonDeserializeCallback; const serializeHandle: Pointer): PNewtonMesh; cdecl; external newtondll;
procedure NewtonMeshDestroy (const mesh: PNewtonMesh); cdecl; external newtondll;
procedure NewtonMeshSerialize (const mesh: PNewtonMesh; serializeFunction: NewtonSerializeCallback; const serializeHandle: Pointer); cdecl; external newtondll;
procedure NewtonMeshSaveOFF (const mesh: PNewtonMesh; const filename: pchar); cdecl; external newtondll;
function NewtonMeshLoadOFF (const newtonWorld: PNewtonWorld; const filename: pchar): PNewtonMesh; cdecl; external newtondll;
function NewtonMeshLoadTetrahedraMesh (const newtonWorld: PNewtonWorld; const filename: pchar): PNewtonMesh; cdecl; external newtondll;
procedure NewtonMeshFlipWinding (const mesh: PNewtonMesh); cdecl; external newtondll;
procedure NewtonMeshApplyTransform (const mesh: PNewtonMesh; const matrix: pfloat); cdecl; external newtondll;
procedure NewtonMeshCalculateOOBB (const mesh: PNewtonMesh; const matrix: pfloat; const x: pfloat; const y: pfloat; const z: pfloat); cdecl; external newtondll;
procedure NewtonMeshCalculateVertexNormals (const mesh: PNewtonMesh; angleInRadians: dfloat); cdecl; external newtondll;
procedure NewtonMeshApplySphericalMapping (const mesh: PNewtonMesh; material: Integer; const aligmentMatrix: pfloat); cdecl; external newtondll;
procedure NewtonMeshApplyCylindricalMapping (const mesh: PNewtonMesh; cylinderMaterial: Integer; capMaterial: Integer; const aligmentMatrix: pfloat); cdecl; external newtondll;
procedure NewtonMeshApplyBoxMapping (const mesh: PNewtonMesh; frontMaterial: Integer; sideMaterial: Integer; topMaterial: Integer; const aligmentMatrix: pfloat); cdecl; external newtondll;
procedure NewtonMeshApplyAngleBasedMapping (const mesh: PNewtonMesh; material: Integer; reportPrograssCallback: NewtonReportProgress; const reportPrgressUserData: Pointer; const aligmentMatrix: pfloat); cdecl; external newtondll;
procedure NewtonCreateTetrahedraLinearBlendSkinWeightsChannel (const tetrahedraMesh: PNewtonMesh; const skinMesh: PNewtonMesh); cdecl; external newtondll;
procedure NewtonMeshOptimize (const mesh: PNewtonMesh); cdecl; external newtondll;
procedure NewtonMeshOptimizePoints (const mesh: PNewtonMesh); cdecl; external newtondll;
procedure NewtonMeshOptimizeVertex (const mesh: PNewtonMesh); cdecl; external newtondll;
function NewtonMeshIsOpenMesh (const mesh: PNewtonMesh): Integer; cdecl; external newtondll;
procedure NewtonMeshFixTJoints (const mesh: PNewtonMesh); cdecl; external newtondll;
procedure NewtonMeshPolygonize (const mesh: PNewtonMesh); cdecl; external newtondll;
procedure NewtonMeshTriangulate (const mesh: PNewtonMesh); cdecl; external newtondll;
function NewtonMeshUnion (const mesh: PNewtonMesh; const clipper: PNewtonMesh; const clipperMatrix: pfloat): PNewtonMesh; cdecl; external newtondll;
function NewtonMeshDifference (const mesh: PNewtonMesh; const clipper: PNewtonMesh; const clipperMatrix: pfloat): PNewtonMesh; cdecl; external newtondll;
function NewtonMeshIntersection (const mesh: PNewtonMesh; const clipper: PNewtonMesh; const clipperMatrix: pfloat): PNewtonMesh; cdecl; external newtondll;
procedure NewtonMeshClip (const mesh: PNewtonMesh; const clipper: PNewtonMesh; const clipperMatrix: pfloat; const topMesh: PNewtonMesh; const bottomMesh: PNewtonMesh); cdecl; external newtondll;
function NewtonMeshConvexMeshIntersection (const mesh: PNewtonMesh; const convexMesh: PNewtonMesh): PNewtonMesh; cdecl; external newtondll;
function NewtonMeshSimplify (const mesh: PNewtonMesh; maxVertexCount: Integer; reportPrograssCallback: NewtonReportProgress; const reportPrgressUserData: Pointer): PNewtonMesh; cdecl; external newtondll;
function NewtonMeshApproximateConvexDecomposition (const mesh: PNewtonMesh; maxConcavity: dfloat; backFaceDistanceFactor: dfloat; maxCount: Integer; maxVertexPerHull: Integer; reportProgressCallback: NewtonReportProgress; const reportProgressUserData: Pointer): PNewtonMesh; cdecl; external newtondll;
procedure NewtonRemoveUnusedVertices (const mesh: PNewtonMesh; const vertexRemapTable: Pinteger); cdecl; external newtondll;
procedure NewtonMeshBeginBuild (const mesh: PNewtonMesh); cdecl; external newtondll;
procedure NewtonMeshBeginFace (const mesh: PNewtonMesh); cdecl; external newtondll;
procedure NewtonMeshAddPoint (const mesh: PNewtonMesh; x: double; y: double; z: double); cdecl; external newtondll;
procedure NewtonMeshAddLayer (const mesh: PNewtonMesh; layerIndex: Integer); cdecl; external newtondll;
procedure NewtonMeshAddMaterial (const mesh: PNewtonMesh; materialIndex: Integer); cdecl; external newtondll;
procedure NewtonMeshAddNormal (const mesh: PNewtonMesh; x: dfloat; y: dfloat; z: dfloat); cdecl; external newtondll;
procedure NewtonMeshAddBinormal (const mesh: PNewtonMesh; x: dfloat; y: dfloat; z: dfloat); cdecl; external newtondll;
procedure NewtonMeshAddUV0 (const mesh: PNewtonMesh; u: dfloat; v: dfloat); cdecl; external newtondll;
procedure NewtonMeshAddUV1 (const mesh: PNewtonMesh; u: dfloat; v: dfloat); cdecl; external newtondll;
procedure NewtonMeshAddVertexColor (const mesh: PNewtonMesh; r: Single; g: Single; b: Single; a: Single); cdecl; external newtondll;
procedure NewtonMeshEndFace (const mesh: PNewtonMesh); cdecl; external newtondll;
procedure NewtonMeshEndBuild (const mesh: PNewtonMesh); cdecl; external newtondll;
procedure NewtonMeshClearVertexFormat (const format: PNewtonMeshVertexFormat); cdecl; external newtondll;
procedure NewtonMeshBuildFromVertexListIndexList (const mesh: PNewtonMesh; const format: PNewtonMeshVertexFormat); cdecl; external newtondll;
function NewtonMeshGetPointCount (const mesh: PNewtonMesh): Integer; cdecl; external newtondll;
function NewtonMeshGetIndexToVertexMap (const mesh: PNewtonMesh): Pinteger; cdecl; external newtondll;
procedure NewtonMeshGetVertexDoubleChannel (const mesh: PNewtonMesh; vertexStrideInByte: Integer; const outBuffer: Pdouble); cdecl; external newtondll;
procedure NewtonMeshGetVertexChannel (const mesh: PNewtonMesh; vertexStrideInByte: Integer; const outBuffer: pfloat); cdecl; external newtondll;
procedure NewtonMeshGetNormalChannel (const mesh: PNewtonMesh; vertexStrideInByte: Integer; const outBuffer: pfloat); cdecl; external newtondll;
procedure NewtonMeshGetBinormalChannel (const mesh: PNewtonMesh; vertexStrideInByte: Integer; const outBuffer: pfloat); cdecl; external newtondll;
procedure NewtonMeshGetUV0Channel (const mesh: PNewtonMesh; vertexStrideInByte: Integer; const outBuffer: pfloat); cdecl; external newtondll;
procedure NewtonMeshGetUV1Channel (const mesh: PNewtonMesh; vertexStrideInByte: Integer; const outBuffer: pfloat); cdecl; external newtondll;
procedure NewtonMeshGetVertexColorChannel (const mesh: PNewtonMesh; vertexStrideInByte: Integer; const outBuffer: pfloat); cdecl; external newtondll;
function NewtonMeshHasNormalChannel (const mesh: PNewtonMesh): Integer; cdecl; external newtondll;
function NewtonMeshHasBinormalChannel (const mesh: PNewtonMesh): Integer; cdecl; external newtondll;
function NewtonMeshHasUV0Channel (const mesh: PNewtonMesh): Integer; cdecl; external newtondll;
function NewtonMeshHasUV1Channel (const mesh: PNewtonMesh): Integer; cdecl; external newtondll;
function NewtonMeshHasVertexColorChannel (const mesh: PNewtonMesh): Integer; cdecl; external newtondll;
function NewtonMeshBeginHandle (const mesh: PNewtonMesh): Pointer; cdecl; external newtondll;
procedure NewtonMeshEndHandle (const mesh: PNewtonMesh; const handle: Pointer); cdecl; external newtondll;
function NewtonMeshFirstMaterial (const mesh: PNewtonMesh; const handle: Pointer): Integer; cdecl; external newtondll;
function NewtonMeshNextMaterial (const mesh: PNewtonMesh; const handle: Pointer; materialId: Integer): Integer; cdecl; external newtondll;
function NewtonMeshMaterialGetMaterial (const mesh: PNewtonMesh; const handle: Pointer; materialId: Integer): Integer; cdecl; external newtondll;
function NewtonMeshMaterialGetIndexCount (const mesh: PNewtonMesh; const handle: Pointer; materialId: Integer): Integer; cdecl; external newtondll;
procedure NewtonMeshMaterialGetIndexStream (const mesh: PNewtonMesh; const handle: Pointer; materialId: Integer; const index: Pinteger); cdecl; external newtondll;
procedure NewtonMeshMaterialGetIndexStreamShort (const mesh: PNewtonMesh; const handle: Pointer; materialId: Integer; const index: SmallInt); cdecl; external newtondll;
function NewtonMeshCreateFirstSingleSegment (const mesh: PNewtonMesh): PNewtonMesh; cdecl; external newtondll;
function NewtonMeshCreateNextSingleSegment (const mesh: PNewtonMesh; const segment: PNewtonMesh): PNewtonMesh; cdecl; external newtondll;
function NewtonMeshCreateFirstLayer (const mesh: PNewtonMesh): PNewtonMesh; cdecl; external newtondll;
function NewtonMeshCreateNextLayer (const mesh: PNewtonMesh; const segment: PNewtonMesh): PNewtonMesh; cdecl; external newtondll;
function NewtonMeshGetTotalFaceCount (const mesh: PNewtonMesh): Integer; cdecl; external newtondll;
function NewtonMeshGetTotalIndexCount (const mesh: PNewtonMesh): Integer; cdecl; external newtondll;
procedure NewtonMeshGetFaces (const mesh: PNewtonMesh; const faceIndexCount: Pinteger; const faceMaterial: Pinteger; const faceIndices: PPointer); cdecl; external newtondll;
function NewtonMeshGetVertexCount (const mesh: PNewtonMesh): Integer; cdecl; external newtondll;
function NewtonMeshGetVertexStrideInByte (const mesh: PNewtonMesh): Integer; cdecl; external newtondll;
function NewtonMeshGetVertexArray (const mesh: PNewtonMesh): Pdouble; cdecl; external newtondll;
function NewtonMeshGetVertexBaseCount (const mesh: PNewtonMesh): Integer; cdecl; external newtondll;
procedure NewtonMeshSetVertexBaseCount (const mesh: PNewtonMesh; baseCount: Integer); cdecl; external newtondll;
function NewtonMeshGetFirstVertex (const mesh: PNewtonMesh): Pointer; cdecl; external newtondll;
function NewtonMeshGetNextVertex (const mesh: PNewtonMesh; const vertex: Pointer): Pointer; cdecl; external newtondll;
function NewtonMeshGetVertexIndex (const mesh: PNewtonMesh; const vertex: Pointer): Integer; cdecl; external newtondll;
function NewtonMeshGetFirstPoint (const mesh: PNewtonMesh): Pointer; cdecl; external newtondll;
function NewtonMeshGetNextPoint (const mesh: PNewtonMesh; const point: Pointer): Pointer; cdecl; external newtondll;
function NewtonMeshGetPointIndex (const mesh: PNewtonMesh; const point: Pointer): Integer; cdecl; external newtondll;
function NewtonMeshGetVertexIndexFromPoint (const mesh: PNewtonMesh; const point: Pointer): Integer; cdecl; external newtondll;
function NewtonMeshGetFirstEdge (const mesh: PNewtonMesh): Pointer; cdecl; external newtondll;
function NewtonMeshGetNextEdge (const mesh: PNewtonMesh; const edge: Pointer): Pointer; cdecl; external newtondll;
procedure NewtonMeshGetEdgeIndices (const mesh: PNewtonMesh; const edge: Pointer; const v0: Pinteger; const v1: Pinteger); cdecl; external newtondll;
function NewtonMeshGetFirstFace (const mesh: PNewtonMesh): Pointer; cdecl; external newtondll;
function NewtonMeshGetNextFace (const mesh: PNewtonMesh; const face: Pointer): Pointer; cdecl; external newtondll;
function NewtonMeshIsFaceOpen (const mesh: PNewtonMesh; const face: Pointer): Integer; cdecl; external newtondll;
function NewtonMeshGetFaceMaterial (const mesh: PNewtonMesh; const face: Pointer): Integer; cdecl; external newtondll;
function NewtonMeshGetFaceIndexCount (const mesh: PNewtonMesh; const face: Pointer): Integer; cdecl; external newtondll;
procedure NewtonMeshGetFaceIndices (const mesh: PNewtonMesh; const face: Pointer; const indices: Pinteger); cdecl; external newtondll;
procedure NewtonMeshGetFacePointIndices (const mesh: PNewtonMesh; const face: Pointer; const indices: Pinteger); cdecl; external newtondll;
procedure NewtonMeshCalculateFaceNormal (const mesh: PNewtonMesh; const face: Pointer; const normal: Pdouble); cdecl; external newtondll;
procedure NewtonMeshSetFaceMaterial (const mesh: PNewtonMesh; const face: Pointer; matId: Integer); cdecl; external newtondll;

implementation

end.
