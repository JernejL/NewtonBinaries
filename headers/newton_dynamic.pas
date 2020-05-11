(* Copyright (c) <2003-2020> <Julio Jerez, Newton Game Dynamics>
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
{ Copyright 2005-2020 Jernej L.                                          }
{ Type names are based on original work by S.Spasov(Sury)                }
{ ********************************************************************** }

// Define double to use newton in double precision

{$undef double}
{.$i compiler.inc} // uncomment if you use custom compiler defines.

unit Newton;

interface

uses windows; 

const
  {$ifdef Windows}
  newtondll = 'Newton.dll';
  {$else}
  newtondll = 'libnewton.so';
  {$endif}

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
	NEWTON_MINOR_VERSION			=	15;
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

TNewtonMaterialData = packed record
case integer of
1: (
	m_ptr: Pointer;
);
2: (
	m_int: int64;
);
3: (
	m_float: dfloat;
);
end;
PNewtonMaterialData = ^TNewtonMaterialData;

TNewtonCollisionMaterial = packed record
	m_userId: int64;
	m_userData: TNewtonMaterialData;
	m_userParam: array[0..5] of TNewtonMaterialData;
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
	m_vertialElevation: Pointer;
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
var

	NewtonLibrary: HINST;

NewtonWorldGetVersion: function (): Integer; cdecl;
NewtonWorldFloatSize: function (): Integer; cdecl;
NewtonGetMemoryUsed: function (): Integer; cdecl;
NewtonSetMemorySystem: procedure (malloc: NewtonAllocMemory; free: NewtonFreeMemory); cdecl;
NewtonCreate: function (): PNewtonWorld; cdecl;
NewtonDestroy: procedure (const newtonWorld: PNewtonWorld); cdecl;
NewtonDestroyAllBodies: procedure (const newtonWorld: PNewtonWorld); cdecl;
NewtonGetPostUpdateCallback: function (const newtonWorld: PNewtonWorld): PNewtonPostUpdateCallback; cdecl;
NewtonSetPostUpdateCallback: procedure (const newtonWorld: PNewtonWorld; callback: NewtonPostUpdateCallback); cdecl;
NewtonAlloc: function (sizeInBytes: Integer): Pointer; cdecl;
NewtonFree: procedure (const ptr: Pointer); cdecl;
NewtonLoadPlugins: procedure (const newtonWorld: PNewtonWorld; const plugInPath: pchar); cdecl;
NewtonUnloadPlugins: procedure (const newtonWorld: PNewtonWorld); cdecl;
NewtonCurrentPlugin: function (const newtonWorld: PNewtonWorld): Pointer; cdecl;
NewtonGetFirstPlugin: function (const newtonWorld: PNewtonWorld): Pointer; cdecl;
NewtonGetPreferedPlugin: function (const newtonWorld: PNewtonWorld): Pointer; cdecl;
NewtonGetNextPlugin: function (const newtonWorld: PNewtonWorld; const plugin: Pointer): Pointer; cdecl;
NewtonGetPluginString: function (const newtonWorld: PNewtonWorld; const plugin: Pointer): pchar; cdecl;
NewtonSelectPlugin: procedure (const newtonWorld: PNewtonWorld; const plugin: Pointer); cdecl;
NewtonGetContactMergeTolerance: function (const newtonWorld: PNewtonWorld): dfloat; cdecl;
NewtonSetContactMergeTolerance: procedure (const newtonWorld: PNewtonWorld; tolerance: dfloat); cdecl;
NewtonInvalidateCache: procedure (const newtonWorld: PNewtonWorld); cdecl;
NewtonSetSolverIterations: procedure (const newtonWorld: PNewtonWorld; model: Integer); cdecl;
NewtonGetSolverIterations: function (const newtonWorld: PNewtonWorld): Integer; cdecl;
NewtonSetParallelSolverOnLargeIsland: procedure (const newtonWorld: PNewtonWorld; mode: Integer); cdecl;
NewtonGetParallelSolverOnLargeIsland: function (const newtonWorld: PNewtonWorld): Integer; cdecl;
NewtonGetBroadphaseAlgorithm: function (const newtonWorld: PNewtonWorld): Integer; cdecl;
NewtonSelectBroadphaseAlgorithm: procedure (const newtonWorld: PNewtonWorld; algorithmType: Integer); cdecl;
NewtonResetBroadphase: procedure (const newtonWorld: PNewtonWorld); cdecl;
NewtonUpdate: procedure (const newtonWorld: PNewtonWorld; timestep: dfloat); cdecl;
NewtonUpdateAsync: procedure (const newtonWorld: PNewtonWorld; timestep: dfloat); cdecl;
NewtonWaitForUpdateToFinish: procedure (const newtonWorld: PNewtonWorld); cdecl;
NewtonGetNumberOfSubsteps: function (const newtonWorld: PNewtonWorld): Integer; cdecl;
NewtonSetNumberOfSubsteps: procedure (const newtonWorld: PNewtonWorld; subSteps: Integer); cdecl;
NewtonGetLastUpdateTime: function (const newtonWorld: PNewtonWorld): dfloat; cdecl;
NewtonSerializeToFile: procedure (const newtonWorld: PNewtonWorld; const filename: pchar; bodyCallback: NewtonOnBodySerializationCallback; const bodyUserData: Pointer); cdecl;
NewtonDeserializeFromFile: procedure (const newtonWorld: PNewtonWorld; const filename: pchar; bodyCallback: NewtonOnBodyDeserializationCallback; const bodyUserData: Pointer); cdecl;
NewtonSerializeScene: procedure (const newtonWorld: PNewtonWorld; bodyCallback: NewtonOnBodySerializationCallback; const bodyUserData: Pointer; serializeCallback: NewtonSerializeCallback; const serializeHandle: Pointer); cdecl;
NewtonDeserializeScene: procedure (const newtonWorld: PNewtonWorld; bodyCallback: NewtonOnBodyDeserializationCallback; const bodyUserData: Pointer; serializeCallback: NewtonDeserializeCallback; const serializeHandle: Pointer); cdecl;
NewtonFindSerializedBody: function (const newtonWorld: PNewtonWorld; bodySerializedID: Integer): pNewtonBody; cdecl;
NewtonSetJointSerializationCallbacks: procedure (const newtonWorld: PNewtonWorld; serializeJoint: NewtonOnJointSerializationCallback; deserializeJoint: NewtonOnJointDeserializationCallback); cdecl;
NewtonGetJointSerializationCallbacks: procedure (const newtonWorld: PNewtonWorld; const serializeJoint: NewtonOnJointSerializationCallback; const deserializeJoint: NewtonOnJointDeserializationCallback); cdecl;
NewtonWorldCriticalSectionLock: procedure (const newtonWorld: PNewtonWorld; threadIndex: Integer); cdecl;
NewtonWorldCriticalSectionUnlock: procedure (const newtonWorld: PNewtonWorld); cdecl;
NewtonSetThreadsCount: procedure (const newtonWorld: PNewtonWorld; threads: Integer); cdecl;
NewtonGetThreadsCount: function (const newtonWorld: PNewtonWorld): Integer; cdecl;
NewtonGetMaxThreadsCount: function (const newtonWorld: PNewtonWorld): Integer; cdecl;
NewtonDispachThreadJob: procedure (const newtonWorld: PNewtonWorld; task: NewtonJobTask; const usedData: Pointer; const functionName: pchar); cdecl;
NewtonSyncThreadJobs: procedure (const newtonWorld: PNewtonWorld); cdecl;
NewtonAtomicAdd: function (const ptr: Pinteger; value: Integer): Integer; cdecl;
NewtonAtomicSwap: function (const ptr: Pinteger; value: Integer): Integer; cdecl;
NewtonYield: procedure (); cdecl;
NewtonSetIslandUpdateEvent: procedure (const newtonWorld: PNewtonWorld; islandUpdate: NewtonIslandUpdate); cdecl;
NewtonWorldForEachJointDo: procedure (const newtonWorld: PNewtonWorld; callback: NewtonJointIterator; const userData: Pointer); cdecl;
NewtonWorldForEachBodyInAABBDo: procedure (const newtonWorld: PNewtonWorld; const p0: pfloat; const p1: pfloat; callback: NewtonBodyIterator; const userData: Pointer); cdecl;
NewtonWorldSetUserData: procedure (const newtonWorld: PNewtonWorld; const userData: Pointer); cdecl;
NewtonWorldGetUserData: function (const newtonWorld: PNewtonWorld): Pointer; cdecl;
NewtonWorldAddListener: function (const newtonWorld: PNewtonWorld; const nameId: pchar; const listenerUserData: Pointer): Pointer; cdecl;
NewtonWorldGetListener: function (const newtonWorld: PNewtonWorld; const nameId: pchar): Pointer; cdecl;
NewtonWorldListenerSetDebugCallback: procedure (const newtonWorld: PNewtonWorld; const listener: Pointer; callback: NewtonWorldListenerDebugCallback); cdecl;
NewtonWorldListenerSetPostStepCallback: procedure (const newtonWorld: PNewtonWorld; const listener: Pointer; callback: NewtonWorldUpdateListenerCallback); cdecl;
NewtonWorldListenerSetPreUpdateCallback: procedure (const newtonWorld: PNewtonWorld; const listener: Pointer; callback: NewtonWorldUpdateListenerCallback); cdecl;
NewtonWorldListenerSetPostUpdateCallback: procedure (const newtonWorld: PNewtonWorld; const listener: Pointer; callback: NewtonWorldUpdateListenerCallback); cdecl;
NewtonWorldListenerSetDestructorCallback: procedure (const newtonWorld: PNewtonWorld; const listener: Pointer; callback: NewtonWorldDestroyListenerCallback); cdecl;
NewtonWorldListenerSetBodyDestroyCallback: procedure (const newtonWorld: PNewtonWorld; const listener: Pointer; callback: NewtonWorldListenerBodyDestroyCallback); cdecl;
NewtonWorldListenerDebug: procedure (const newtonWorld: PNewtonWorld; const context: Pointer); cdecl;
NewtonWorldGetListenerUserData: function (const newtonWorld: PNewtonWorld; const listener: Pointer): Pointer; cdecl;
NewtonWorldListenerGetBodyDestroyCallback: function (const newtonWorld: PNewtonWorld; const listener: Pointer): PNewtonWorldListenerBodyDestroyCallback; cdecl;
NewtonWorldSetDestructorCallback: procedure (const newtonWorld: PNewtonWorld; destructorparam: NewtonWorldDestructorCallback); cdecl;
NewtonWorldGetDestructorCallback: function (const newtonWorld: PNewtonWorld): PNewtonWorldDestructorCallback; cdecl;
NewtonWorldSetCollisionConstructorDestructorCallback: procedure (const newtonWorld: PNewtonWorld; constructorparam: NewtonCollisionCopyConstructionCallback; destructorparam: NewtonCollisionDestructorCallback); cdecl;
NewtonWorldSetCreateDestroyContactCallback: procedure (const newtonWorld: PNewtonWorld; createContact: NewtonCreateContactCallback; destroyContact: NewtonDestroyContactCallback); cdecl;
NewtonWorldRayCast: procedure (const newtonWorld: PNewtonWorld; const p0: pfloat; const p1: pfloat; filter: NewtonWorldRayFilterCallback; const userData: Pointer; prefilter: NewtonWorldRayPrefilterCallback; threadIndex: Integer); cdecl;
NewtonWorldConvexCast: function (const newtonWorld: PNewtonWorld; const matrix: pfloat; const target: pfloat; const shape: PNewtonCollision; const param: pfloat; const userData: Pointer; prefilter: NewtonWorldRayPrefilterCallback; const info: PNewtonWorldConvexCastReturnInfo; maxContactsCount: Integer; threadIndex: Integer): Integer; cdecl;
NewtonWorldCollide: function (const newtonWorld: PNewtonWorld; const matrix: pfloat; const shape: PNewtonCollision; const userData: Pointer; prefilter: NewtonWorldRayPrefilterCallback; const info: PNewtonWorldConvexCastReturnInfo; maxContactsCount: Integer; threadIndex: Integer): Integer; cdecl;
NewtonWorldGetBodyCount: function (const newtonWorld: PNewtonWorld): Integer; cdecl;
NewtonWorldGetConstraintCount: function (const newtonWorld: PNewtonWorld): Integer; cdecl;
NewtonWorldFindJoint: function (const body0: pNewtonBody; const body1: pNewtonBody): PNewtonJoint; cdecl;
{ Simulation islands }
NewtonIslandGetBody: function (const island: Pointer; bodyIndex: Integer): pNewtonBody; cdecl;
NewtonIslandGetBodyAABB: procedure (const island: Pointer; bodyIndex: Integer; const p0: pfloat; const p1: pfloat); cdecl;
{ Physics Material Section }
NewtonMaterialCreateGroupID: function (const newtonWorld: PNewtonWorld): Integer; cdecl;
NewtonMaterialGetDefaultGroupID: function (const newtonWorld: PNewtonWorld): Integer; cdecl;
NewtonMaterialDestroyAllGroupID: procedure (const newtonWorld: PNewtonWorld); cdecl;
NewtonMaterialGetUserData: function (const newtonWorld: PNewtonWorld; id0: Integer; id1: Integer): Pointer; cdecl;
NewtonMaterialSetSurfaceThickness: procedure (const newtonWorld: PNewtonWorld; id0: Integer; id1: Integer; thickness: dfloat); cdecl;
NewtonMaterialSetCallbackUserData: procedure (const newtonWorld: PNewtonWorld; id0: Integer; id1: Integer; const userData: Pointer); cdecl;
NewtonMaterialSetContactGenerationCallback: procedure (const newtonWorld: PNewtonWorld; id0: Integer; id1: Integer; contactGeneration: NewtonOnContactGeneration); cdecl;
NewtonMaterialSetCompoundCollisionCallback: procedure (const newtonWorld: PNewtonWorld; id0: Integer; id1: Integer; compoundAabbOverlap: NewtonOnCompoundSubCollisionAABBOverlap); cdecl;
NewtonMaterialSetCollisionCallback: procedure (const newtonWorld: PNewtonWorld; id0: Integer; id1: Integer; aabbOverlap: NewtonOnAABBOverlap; process: NewtonContactsProcess); cdecl;
NewtonMaterialSetDefaultSoftness: procedure (const newtonWorld: PNewtonWorld; id0: Integer; id1: Integer; value: dfloat); cdecl;
NewtonMaterialSetDefaultElasticity: procedure (const newtonWorld: PNewtonWorld; id0: Integer; id1: Integer; elasticCoef: dfloat); cdecl;
NewtonMaterialSetDefaultCollidable: procedure (const newtonWorld: PNewtonWorld; id0: Integer; id1: Integer; state: Integer); cdecl;
NewtonMaterialSetDefaultFriction: procedure (const newtonWorld: PNewtonWorld; id0: Integer; id1: Integer; staticFriction: dfloat; kineticFriction: dfloat); cdecl;
NewtonMaterialJointResetIntraJointCollision: procedure (const newtonWorld: PNewtonWorld; id0: Integer; id1: Integer); cdecl;
NewtonMaterialJointResetSelftJointCollision: procedure (const newtonWorld: PNewtonWorld; id0: Integer; id1: Integer); cdecl;
NewtonWorldGetFirstMaterial: function (const newtonWorld: PNewtonWorld): PNewtonMaterial; cdecl;
NewtonWorldGetNextMaterial: function (const newtonWorld: PNewtonWorld; const material: PNewtonMaterial): PNewtonMaterial; cdecl;
NewtonWorldGetFirstBody: function (const newtonWorld: PNewtonWorld): pNewtonBody; cdecl;
NewtonWorldGetNextBody: function (const newtonWorld: PNewtonWorld; const curBody: pNewtonBody): pNewtonBody; cdecl;
{ Physics Contact control functions }
NewtonMaterialGetMaterialPairUserData: function (const material: PNewtonMaterial): Pointer; cdecl;
NewtonMaterialGetContactFaceAttribute: function (const material: PNewtonMaterial): LongWord; cdecl;
NewtonMaterialGetBodyCollidingShape: function (const material: PNewtonMaterial; const body: pNewtonBody): PNewtonCollision; cdecl;
NewtonMaterialGetContactNormalSpeed: function (const material: PNewtonMaterial): dfloat; cdecl;
NewtonMaterialGetContactForce: procedure (const material: PNewtonMaterial; const body: pNewtonBody; const force: pfloat); cdecl;
NewtonMaterialGetContactPositionAndNormal: procedure (const material: PNewtonMaterial; const body: pNewtonBody; const posit: pfloat; const normal: pfloat); cdecl;
NewtonMaterialGetContactTangentDirections: procedure (const material: PNewtonMaterial; const body: pNewtonBody; const dir0: pfloat; const dir1: pfloat); cdecl;
NewtonMaterialGetContactTangentSpeed: function (const material: PNewtonMaterial; index: Integer): dfloat; cdecl;
NewtonMaterialGetContactMaxNormalImpact: function (const material: PNewtonMaterial): dfloat; cdecl;
NewtonMaterialGetContactMaxTangentImpact: function (const material: PNewtonMaterial; index: Integer): dfloat; cdecl;
NewtonMaterialGetContactPenetration: function (const material: PNewtonMaterial): dfloat; cdecl;
NewtonMaterialSetAsSoftContact: procedure (const material: PNewtonMaterial; relaxation: dfloat); cdecl;
NewtonMaterialSetContactSoftness: procedure (const material: PNewtonMaterial; softness: dfloat); cdecl;
NewtonMaterialSetContactThickness: procedure (const material: PNewtonMaterial; thickness: dfloat); cdecl;
NewtonMaterialSetContactElasticity: procedure (const material: PNewtonMaterial; restitution: dfloat); cdecl;
NewtonMaterialSetContactFrictionState: procedure (const material: PNewtonMaterial; state: Integer; index: Integer); cdecl;
NewtonMaterialSetContactFrictionCoef: procedure (const material: PNewtonMaterial; staticFrictionCoef: dfloat; kineticFrictionCoef: dfloat; index: Integer); cdecl;
NewtonMaterialSetContactNormalAcceleration: procedure (const material: PNewtonMaterial; accel: dfloat); cdecl;
NewtonMaterialSetContactNormalDirection: procedure (const material: PNewtonMaterial; const directionVector: pfloat); cdecl;
NewtonMaterialSetContactPosition: procedure (const material: PNewtonMaterial; const position: pfloat); cdecl;
NewtonMaterialSetContactTangentFriction: procedure (const material: PNewtonMaterial; friction: dfloat; index: Integer); cdecl;
NewtonMaterialSetContactTangentAcceleration: procedure (const material: PNewtonMaterial; accel: dfloat; index: Integer); cdecl;
NewtonMaterialContactRotateTangentDirections: procedure (const material: PNewtonMaterial; const directionVector: pfloat); cdecl;
NewtonMaterialGetContactPruningTolerance: function (const contactJoint: PNewtonJoint): dfloat; cdecl;
NewtonMaterialSetContactPruningTolerance: procedure (const contactJoint: PNewtonJoint; tolerance: dfloat); cdecl;
{ convex collision primitives creation functions }
NewtonCreateNull: function (const newtonWorld: PNewtonWorld): PNewtonCollision; cdecl;
NewtonCreateSphere: function (const newtonWorld: PNewtonWorld; radius: dfloat; shapeID: Integer; const offsetMatrix: pfloat): PNewtonCollision; cdecl;
NewtonCreateBox: function (const newtonWorld: PNewtonWorld; dx: dfloat; dy: dfloat; dz: dfloat; shapeID: Integer; const offsetMatrix: pfloat): PNewtonCollision; cdecl;
NewtonCreateCone: function (const newtonWorld: PNewtonWorld; radius: dfloat; height: dfloat; shapeID: Integer; const offsetMatrix: pfloat): PNewtonCollision; cdecl;
NewtonCreateCapsule: function (const newtonWorld: PNewtonWorld; radius0: dfloat; radius1: dfloat; height: dfloat; shapeID: Integer; const offsetMatrix: pfloat): PNewtonCollision; cdecl;
NewtonCreateCylinder: function (const newtonWorld: PNewtonWorld; radio0: dfloat; radio1: dfloat; height: dfloat; shapeID: Integer; const offsetMatrix: pfloat): PNewtonCollision; cdecl;
NewtonCreateChamferCylinder: function (const newtonWorld: PNewtonWorld; radius: dfloat; height: dfloat; shapeID: Integer; const offsetMatrix: pfloat): PNewtonCollision; cdecl;
NewtonCreateConvexHull: function (const newtonWorld: PNewtonWorld; count: Integer; const vertexCloud: pfloat; strideInBytes: Integer; tolerance: dfloat; shapeID: Integer; const offsetMatrix: pfloat): PNewtonCollision; cdecl;
NewtonCreateConvexHullFromMesh: function (const newtonWorld: PNewtonWorld; const mesh: PNewtonMesh; tolerance: dfloat; shapeID: Integer): PNewtonCollision; cdecl;
NewtonCollisionGetMode: function (const convexCollision: PNewtonCollision): Integer; cdecl;
NewtonCollisionSetMode: procedure (const convexCollision: PNewtonCollision; mode: Integer); cdecl;
NewtonConvexHullGetFaceIndices: function (const convexHullCollision: PNewtonCollision; face: Integer; const faceIndices: Pinteger): Integer; cdecl;
NewtonConvexHullGetVertexData: function (const convexHullCollision: PNewtonCollision; const vertexData: Pfloat; strideInBytes: Pinteger): Integer; cdecl;
NewtonConvexCollisionCalculateVolume: function (const convexCollision: PNewtonCollision): dfloat; cdecl;
NewtonConvexCollisionCalculateInertialMatrix: procedure (const convexCollision: PNewtonCollision; const inertia: pfloat; const origin: pfloat); cdecl;
NewtonConvexCollisionCalculateBuoyancyVolume: function (const convexCollision: PNewtonCollision; const matrix: pfloat; const fluidPlane: pfloat; const centerOfBuoyancy: pfloat): dfloat; cdecl;
NewtonCollisionDataPointer: function (const convexCollision: PNewtonCollision): Pointer; cdecl;
{ compound collision primitives creation functions }
NewtonCreateCompoundCollision: function (const newtonWorld: PNewtonWorld; shapeID: Integer): PNewtonCollision; cdecl;
NewtonCreateCompoundCollisionFromMesh: function (const newtonWorld: PNewtonWorld; const mesh: PNewtonMesh; hullTolerance: dfloat; shapeID: Integer; subShapeID: Integer): PNewtonCollision; cdecl;
NewtonCompoundCollisionBeginAddRemove: procedure (const compoundCollision: PNewtonCollision); cdecl;
NewtonCompoundCollisionAddSubCollision: function (const compoundCollision: PNewtonCollision; const convexCollision: PNewtonCollision): Pointer; cdecl;
NewtonCompoundCollisionRemoveSubCollision: procedure (const compoundCollision: PNewtonCollision; const collisionNode: Pointer); cdecl;
NewtonCompoundCollisionRemoveSubCollisionByIndex: procedure (const compoundCollision: PNewtonCollision; nodeIndex: Integer); cdecl;
NewtonCompoundCollisionSetSubCollisionMatrix: procedure (const compoundCollision: PNewtonCollision; const collisionNode: Pointer; const matrix: pfloat); cdecl;
NewtonCompoundCollisionEndAddRemove: procedure (const compoundCollision: PNewtonCollision); cdecl;
NewtonCompoundCollisionGetFirstNode: function (const compoundCollision: PNewtonCollision): Pointer; cdecl;
NewtonCompoundCollisionGetNextNode: function (const compoundCollision: PNewtonCollision; const collisionNode: Pointer): Pointer; cdecl;
NewtonCompoundCollisionGetNodeByIndex: function (const compoundCollision: PNewtonCollision; index: Integer): Pointer; cdecl;
NewtonCompoundCollisionGetNodeIndex: function (const compoundCollision: PNewtonCollision; const collisionNode: Pointer): Integer; cdecl;
NewtonCompoundCollisionGetCollisionFromNode: function (const compoundCollision: PNewtonCollision; const collisionNode: Pointer): PNewtonCollision; cdecl;
{ Fractured compound collision primitives interface }
NewtonCreateFracturedCompoundCollision: function (const newtonWorld: PNewtonWorld; const solidMesh: PNewtonMesh; shapeID: Integer; fracturePhysicsMaterialID: Integer; pointcloudCount: Integer; const vertexCloud: pfloat; strideInBytes: Integer; materialID: Integer; const textureMatrix: pfloat; regenerateMainMeshCallback: NewtonFractureCompoundCollisionReconstructMainMeshCallBack; emitFracturedCompound: NewtonFractureCompoundCollisionOnEmitCompoundFractured; emitFracfuredChunk: NewtonFractureCompoundCollisionOnEmitChunk): PNewtonCollision; cdecl;
NewtonFracturedCompoundPlaneClip: function (const fracturedCompound: PNewtonCollision; const plane: pfloat): PNewtonCollision; cdecl;
NewtonFracturedCompoundSetCallbacks: procedure (const fracturedCompound: PNewtonCollision; regenerateMainMeshCallback: NewtonFractureCompoundCollisionReconstructMainMeshCallBack; emitFracturedCompound: NewtonFractureCompoundCollisionOnEmitCompoundFractured; emitFracfuredChunk: NewtonFractureCompoundCollisionOnEmitChunk); cdecl;
NewtonFracturedCompoundIsNodeFreeToDetach: function (const fracturedCompound: PNewtonCollision; const collisionNode: Pointer): Integer; cdecl;
NewtonFracturedCompoundNeighborNodeList: function (const fracturedCompound: PNewtonCollision; const collisionNode: Pointer; const list: PPointer; maxCount: Integer): Integer; cdecl;
NewtonFracturedCompoundGetMainMesh: function (const fracturedCompound: PNewtonCollision): PNewtonFracturedCompoundMeshPart; cdecl;
NewtonFracturedCompoundGetFirstSubMesh: function (const fracturedCompound: PNewtonCollision): PNewtonFracturedCompoundMeshPart; cdecl;
NewtonFracturedCompoundGetNextSubMesh: function (const fracturedCompound: PNewtonCollision; const subMesh: PNewtonFracturedCompoundMeshPart): PNewtonFracturedCompoundMeshPart; cdecl;
NewtonFracturedCompoundCollisionGetVertexCount: function (const fracturedCompound: PNewtonCollision; const meshOwner: PNewtonFracturedCompoundMeshPart): Integer; cdecl;
NewtonFracturedCompoundCollisionGetVertexPositions: function (const fracturedCompound: PNewtonCollision; const meshOwner: PNewtonFracturedCompoundMeshPart): pfloat; cdecl;
NewtonFracturedCompoundCollisionGetVertexNormals: function (const fracturedCompound: PNewtonCollision; const meshOwner: PNewtonFracturedCompoundMeshPart): pfloat; cdecl;
NewtonFracturedCompoundCollisionGetVertexUVs: function (const fracturedCompound: PNewtonCollision; const meshOwner: PNewtonFracturedCompoundMeshPart): pfloat; cdecl;
NewtonFracturedCompoundMeshPartGetIndexStream: function (const fracturedCompound: PNewtonCollision; const meshOwner: PNewtonFracturedCompoundMeshPart; const segment: Pointer; const index: Pinteger): Integer; cdecl;
NewtonFracturedCompoundMeshPartGetFirstSegment: function (const fractureCompoundMeshPart: PNewtonFracturedCompoundMeshPart): Pointer; cdecl;
NewtonFracturedCompoundMeshPartGetNextSegment: function (const fractureCompoundMeshSegment: Pointer): Pointer; cdecl;
NewtonFracturedCompoundMeshPartGetMaterial: function (const fractureCompoundMeshSegment: Pointer): Integer; cdecl;
NewtonFracturedCompoundMeshPartGetIndexCount: function (const fractureCompoundMeshSegment: Pointer): Integer; cdecl;
{ scene collision are static compound collision that can take polygonal static collisions }
NewtonCreateSceneCollision: function (const newtonWorld: PNewtonWorld; shapeID: Integer): PNewtonCollision; cdecl;
NewtonSceneCollisionBeginAddRemove: procedure (const sceneCollision: PNewtonCollision); cdecl;
NewtonSceneCollisionAddSubCollision: function (const sceneCollision: PNewtonCollision; const collision: PNewtonCollision): Pointer; cdecl;
NewtonSceneCollisionRemoveSubCollision: procedure (const compoundCollision: PNewtonCollision; const collisionNode: Pointer); cdecl;
NewtonSceneCollisionRemoveSubCollisionByIndex: procedure (const sceneCollision: PNewtonCollision; nodeIndex: Integer); cdecl;
NewtonSceneCollisionSetSubCollisionMatrix: procedure (const sceneCollision: PNewtonCollision; const collisionNode: Pointer; const matrix: pfloat); cdecl;
NewtonSceneCollisionEndAddRemove: procedure (const sceneCollision: PNewtonCollision); cdecl;
NewtonSceneCollisionGetFirstNode: function (const sceneCollision: PNewtonCollision): Pointer; cdecl;
NewtonSceneCollisionGetNextNode: function (const sceneCollision: PNewtonCollision; const collisionNode: Pointer): Pointer; cdecl;
NewtonSceneCollisionGetNodeByIndex: function (const sceneCollision: PNewtonCollision; index: Integer): Pointer; cdecl;
NewtonSceneCollisionGetNodeIndex: function (const sceneCollision: PNewtonCollision; const collisionNode: Pointer): Integer; cdecl;
NewtonSceneCollisionGetCollisionFromNode: function (const sceneCollision: PNewtonCollision; const collisionNode: Pointer): PNewtonCollision; cdecl;
{ User Static mesh collision interface }
NewtonCreateUserMeshCollision: function (const newtonWorld: PNewtonWorld; const minBox: pfloat; const maxBox: pfloat; const userData: Pointer; collideCallback: NewtonUserMeshCollisionCollideCallback; rayHitCallback: NewtonUserMeshCollisionRayHitCallback; destroyCallback: NewtonUserMeshCollisionDestroyCallback; getInfoCallback: NewtonUserMeshCollisionGetCollisionInfo; getLocalAABBCallback: NewtonUserMeshCollisionAABBTest; facesInAABBCallback: NewtonUserMeshCollisionGetFacesInAABB; serializeCallback: NewtonOnUserCollisionSerializationCallback; shapeID: Integer): PNewtonCollision; cdecl;
NewtonUserMeshCollisionContinuousOverlapTest: function (const collideDescData: PNewtonUserMeshCollisionCollideDesc; const continueCollisionHandle: Pointer; const minAabb: pfloat; const maxAabb: pfloat): Integer; cdecl;
{ Collision serialization functions }
NewtonCreateCollisionFromSerialization: function (const newtonWorld: PNewtonWorld; deserializeFunction: NewtonDeserializeCallback; const serializeHandle: Pointer): PNewtonCollision; cdecl;
NewtonCollisionSerialize: procedure (const newtonWorld: PNewtonWorld; const collision: PNewtonCollision; serializeFunction: NewtonSerializeCallback; const serializeHandle: Pointer); cdecl;
NewtonCollisionGetInfo: procedure (const collision: PNewtonCollision; const collisionInfo: PNewtonCollisionInfoRecord); cdecl;
{ Static collision shapes functions }
NewtonCreateHeightFieldCollision: function (const newtonWorld: PNewtonWorld; width: Integer; height: Integer; gridsDiagonals: Integer; elevationdatType: Integer; const elevationMap: Pointer; const attributeMap: pchar; verticalScale: dfloat; horizontalScale_x: dfloat; horizontalScale_z: dfloat; shapeID: Integer): PNewtonCollision; cdecl;
NewtonHeightFieldSetUserRayCastCallback: procedure (const heightfieldCollision: PNewtonCollision; rayHitCallback: NewtonHeightFieldRayCastCallback); cdecl;
NewtonCreateTreeCollision: function (const newtonWorld: PNewtonWorld; shapeID: Integer): PNewtonCollision; cdecl;
NewtonCreateTreeCollisionFromMesh: function (const newtonWorld: PNewtonWorld; const mesh: PNewtonMesh; shapeID: Integer): PNewtonCollision; cdecl;
NewtonTreeCollisionSetUserRayCastCallback: procedure (const treeCollision: PNewtonCollision; rayHitCallback: NewtonCollisionTreeRayCastCallback); cdecl;
NewtonTreeCollisionBeginBuild: procedure (const treeCollision: PNewtonCollision); cdecl;
NewtonTreeCollisionAddFace: procedure (const treeCollision: PNewtonCollision; vertexCount: Integer; const vertexPtr: pfloat; strideInBytes: Integer; faceAttribute: Integer); cdecl;
NewtonTreeCollisionEndBuild: procedure (const treeCollision: PNewtonCollision; optimize: Integer); cdecl;
NewtonTreeCollisionGetFaceAttribute: function (const treeCollision: PNewtonCollision; const faceIndexArray: Pinteger; indexCount: Integer): Integer; cdecl;
NewtonTreeCollisionSetFaceAttribute: procedure (const treeCollision: PNewtonCollision; const faceIndexArray: Pinteger; indexCount: Integer; attribute: Integer); cdecl;
NewtonTreeCollisionForEachFace: procedure (const treeCollision: PNewtonCollision; forEachFaceCallback: NewtonTreeCollisionFaceCallback; const context: Pointer); cdecl;
NewtonTreeCollisionGetVertexListTriangleListInAABB: function (const treeCollision: PNewtonCollision; const p0: pfloat; const p1: pfloat; const vertexArray: Pfloat; const vertexCount: Pinteger; const vertexStrideInBytes: Pinteger; const indexList: Pinteger; maxIndexCount: Integer; const faceAttribute: Pinteger): Integer; cdecl;
NewtonStaticCollisionSetDebugCallback: procedure (const staticCollision: PNewtonCollision; userCallback: NewtonTreeCollisionCallback); cdecl;
{ General purpose collision library functions }
NewtonCollisionCreateInstance: function (const collision: PNewtonCollision): PNewtonCollision; cdecl;
NewtonCollisionGetType: function (const collision: PNewtonCollision): Integer; cdecl;
NewtonCollisionIsConvexShape: function (const collision: PNewtonCollision): Integer; cdecl;
NewtonCollisionIsStaticShape: function (const collision: PNewtonCollision): Integer; cdecl;
NewtonCollisionSetUserData: procedure (const collision: PNewtonCollision; const userData: Pointer); cdecl;
NewtonCollisionGetUserData: function (const collision: PNewtonCollision): Pointer; cdecl;
NewtonCollisionSetUserID: procedure (const collision: PNewtonCollision; id: int64); cdecl;
NewtonCollisionGetUserID: function (const collision: PNewtonCollision): int64; cdecl;
NewtonCollisionGetMaterial: procedure (const collision: PNewtonCollision; const userData: PNewtonCollisionMaterial); cdecl;
NewtonCollisionSetMaterial: procedure (const collision: PNewtonCollision; const userData: PNewtonCollisionMaterial); cdecl;
NewtonCollisionGetSubCollisionHandle: function (const collision: PNewtonCollision): Pointer; cdecl;
NewtonCollisionGetParentInstance: function (const collision: PNewtonCollision): PNewtonCollision; cdecl;
NewtonCollisionSetMatrix: procedure (const collision: PNewtonCollision; const matrix: pfloat); cdecl;
NewtonCollisionGetMatrix: procedure (const collision: PNewtonCollision; const matrix: pfloat); cdecl;
NewtonCollisionSetScale: procedure (const collision: PNewtonCollision; scaleX: dfloat; scaleY: dfloat; scaleZ: dfloat); cdecl;
NewtonCollisionGetScale: procedure (const collision: PNewtonCollision; const scaleX: pfloat; const scaleY: pfloat; const scaleZ: pfloat); cdecl;
NewtonDestroyCollision: procedure (const collision: PNewtonCollision); cdecl;
NewtonCollisionGetSkinThickness: function (const collision: PNewtonCollision): dfloat; cdecl;
NewtonCollisionSetSkinThickness: procedure (const collision: PNewtonCollision; thickness: dfloat); cdecl;
NewtonCollisionIntersectionTest: function (const newtonWorld: PNewtonWorld; const collisionA: PNewtonCollision; const matrixA: pfloat; const collisionB: PNewtonCollision; const matrixB: pfloat; threadIndex: Integer): Integer; cdecl;
NewtonCollisionPointDistance: function (const newtonWorld: PNewtonWorld; const point: pfloat; const collision: PNewtonCollision; const matrix: pfloat; const contact: pfloat; const normal: pfloat; threadIndex: Integer): Integer; cdecl;
NewtonCollisionClosestPoint: function (const newtonWorld: PNewtonWorld; const collisionA: PNewtonCollision; const matrixA: pfloat; const collisionB: PNewtonCollision; const matrixB: pfloat; const contactA: pfloat; const contactB: pfloat; const normalAB: pfloat; threadIndex: Integer): Integer; cdecl;
NewtonCollisionCollide: function (const newtonWorld: PNewtonWorld; maxSize: Integer; const collisionA: PNewtonCollision; const matrixA: pfloat; const collisionB: PNewtonCollision; const matrixB: pfloat; const contacts: pfloat; const normals: pfloat; const penetration: pfloat; const attributeA: Pint64; const attributeB: Pint64; threadIndex: Integer): Integer; cdecl;
NewtonCollisionCollideContinue: function (const newtonWorld: PNewtonWorld; maxSize: Integer; timestep: dfloat; const collisionA: PNewtonCollision; const matrixA: pfloat; const velocA: pfloat; const omegaA: pfloat; const collisionB: PNewtonCollision; const matrixB: pfloat; const velocB: pfloat; const omegaB: pfloat; const timeOfImpact: pfloat; const contacts: pfloat; const normals: pfloat; const penetration: pfloat; const attributeA: Pint64; const attributeB: Pint64; threadIndex: Integer): Integer; cdecl;
NewtonCollisionSupportVertex: procedure (const collision: PNewtonCollision; const dir: pfloat; const vertex: pfloat); cdecl;
NewtonCollisionRayCast: function (const collision: PNewtonCollision; const p0: pfloat; const p1: pfloat; const normal: pfloat; const attribute: Pint64): dfloat; cdecl;
NewtonCollisionCalculateAABB: procedure (const collision: PNewtonCollision; const matrix: pfloat; const p0: pfloat; const p1: pfloat); cdecl;
NewtonCollisionForEachPolygonDo: procedure (const collision: PNewtonCollision; const matrix: pfloat; callback: NewtonCollisionIterator; const userData: Pointer); cdecl;
{ collision aggregates, are a collision node on eh broad phase the serve as the root nod for a collection of rigid bodies
	  that shared the property of being in close proximity all the time, they are similar to compound collision by the group bodies instead of collision instances
	  These are good for speeding calculation calculation of rag doll, Vehicles or contractions of rigid bodied lined by joints.
	  also for example if you know that many the life time of a group of bodies like the object on a house of a building will be localize to the confide of the building
	  then warping the bodies under an aggregate will reduce collision calculation of almost an order of magnitude. }
NewtonCollisionAggregateCreate: function (const world: PNewtonWorld): Pointer; cdecl;
NewtonCollisionAggregateDestroy: procedure (const aggregate: Pointer); cdecl;
NewtonCollisionAggregateAddBody: procedure (const aggregate: Pointer; const body: pNewtonBody); cdecl;
NewtonCollisionAggregateRemoveBody: procedure (const aggregate: Pointer; const body: pNewtonBody); cdecl;
NewtonCollisionAggregateGetSelfCollision: function (const aggregate: Pointer): Integer; cdecl;
NewtonCollisionAggregateSetSelfCollision: procedure (const aggregate: Pointer; state: Integer); cdecl;
{ transforms utility functions }
NewtonSetEulerAngle: procedure (const eulersAngles: pfloat; const matrix: pfloat); cdecl;
NewtonGetEulerAngle: procedure (const matrix: pfloat; const eulersAngles0: pfloat; const eulersAngles1: pfloat); cdecl;
NewtonCalculateSpringDamperAcceleration: function (dt: dfloat; ks: dfloat; x: dfloat; kd: dfloat; s: dfloat): dfloat; cdecl;
{ body manipulation functions }
NewtonCreateDynamicBody: function (const newtonWorld: PNewtonWorld; const collision: PNewtonCollision; const matrix: pfloat): pNewtonBody; cdecl;
NewtonCreateKinematicBody: function (const newtonWorld: PNewtonWorld; const collision: PNewtonCollision; const matrix: pfloat): pNewtonBody; cdecl;
NewtonCreateAsymetricDynamicBody: function (const newtonWorld: PNewtonWorld; const collision: PNewtonCollision; const matrix: pfloat): pNewtonBody; cdecl;
NewtonDestroyBody: procedure (const body: pNewtonBody); cdecl;
NewtonBodyGetSimulationState: function (const body: pNewtonBody): Integer; cdecl;
NewtonBodySetSimulationState: procedure (const bodyPtr: pNewtonBody; const state: Integer); cdecl;
NewtonBodyGetType: function (const body: pNewtonBody): Integer; cdecl;
NewtonBodyGetCollidable: function (const body: pNewtonBody): Integer; cdecl;
NewtonBodySetCollidable: procedure (const body: pNewtonBody; collidableState: Integer); cdecl;
NewtonBodyAddForce: procedure (const body: pNewtonBody; const force: pfloat); cdecl;
NewtonBodyAddTorque: procedure (const body: pNewtonBody; const torque: pfloat); cdecl;
NewtonBodySetCentreOfMass: procedure (const body: pNewtonBody; const com: pfloat); cdecl;
NewtonBodySetMassMatrix: procedure (const body: pNewtonBody; mass: dfloat; Ixx: dfloat; Iyy: dfloat; Izz: dfloat); cdecl;
NewtonBodySetFullMassMatrix: procedure (const body: pNewtonBody; mass: dfloat; const inertiaMatrix: pfloat); cdecl;
NewtonBodySetMassProperties: procedure (const body: pNewtonBody; mass: dfloat; const collision: PNewtonCollision); cdecl;
NewtonBodySetMatrix: procedure (const body: pNewtonBody; const matrix: pfloat); cdecl;
NewtonBodySetMatrixNoSleep: procedure (const body: pNewtonBody; const matrix: pfloat); cdecl;
NewtonBodySetMatrixRecursive: procedure (const body: pNewtonBody; const matrix: pfloat); cdecl;
NewtonBodySetMaterialGroupID: procedure (const body: pNewtonBody; id: Integer); cdecl;
NewtonBodySetContinuousCollisionMode: procedure (const body: pNewtonBody; state: LongWord); cdecl;
NewtonBodySetJointRecursiveCollision: procedure (const body: pNewtonBody; state: LongWord); cdecl;
NewtonBodySetOmega: procedure (const body: pNewtonBody; const omega: pfloat); cdecl;
NewtonBodySetOmegaNoSleep: procedure (const body: pNewtonBody; const omega: pfloat); cdecl;
NewtonBodySetVelocity: procedure (const body: pNewtonBody; const velocity: pfloat); cdecl;
NewtonBodySetVelocityNoSleep: procedure (const body: pNewtonBody; const velocity: pfloat); cdecl;
NewtonBodySetForce: procedure (const body: pNewtonBody; const force: pfloat); cdecl;
NewtonBodySetTorque: procedure (const body: pNewtonBody; const torque: pfloat); cdecl;
NewtonBodySetLinearDamping: procedure (const body: pNewtonBody; linearDamp: dfloat); cdecl;
NewtonBodySetAngularDamping: procedure (const body: pNewtonBody; const angularDamp: pfloat); cdecl;
NewtonBodySetCollision: procedure (const body: pNewtonBody; const collision: PNewtonCollision); cdecl;
NewtonBodySetCollisionScale: procedure (const body: pNewtonBody; scaleX: dfloat; scaleY: dfloat; scaleZ: dfloat); cdecl;
NewtonBodyGetSleepState: function (const body: pNewtonBody): Integer; cdecl;
NewtonBodySetSleepState: procedure (const body: pNewtonBody; state: Integer); cdecl;
NewtonBodyGetAutoSleep: function (const body: pNewtonBody): Integer; cdecl;
NewtonBodySetAutoSleep: procedure (const body: pNewtonBody; state: Integer); cdecl;
NewtonBodyGetFreezeState: function (const body: pNewtonBody): Integer; cdecl;
NewtonBodySetFreezeState: procedure (const body: pNewtonBody; state: Integer); cdecl;
NewtonBodyGetGyroscopicTorque: function (const body: pNewtonBody): Integer; cdecl;
NewtonBodySetGyroscopicTorque: procedure (const body: pNewtonBody; state: Integer); cdecl;
NewtonBodySetDestructorCallback: procedure (const body: pNewtonBody; callback: NewtonBodyDestructor); cdecl;
NewtonBodyGetDestructorCallback: function (const body: pNewtonBody): PNewtonBodyDestructor; cdecl;
NewtonBodySetTransformCallback: procedure (const body: pNewtonBody; callback: NewtonSetTransform); cdecl;
NewtonBodyGetTransformCallback: function (const body: pNewtonBody): PNewtonSetTransform; cdecl;
NewtonBodySetForceAndTorqueCallback: procedure (const body: pNewtonBody; callback: NewtonApplyForceAndTorque); cdecl;
NewtonBodyGetForceAndTorqueCallback: function (const body: pNewtonBody): PNewtonApplyForceAndTorque; cdecl;
NewtonBodyGetID: function (const body: pNewtonBody): Integer; cdecl;
NewtonBodySetUserData: procedure (const body: pNewtonBody; const userData: Pointer); cdecl;
NewtonBodyGetUserData: function (const body: pNewtonBody): Pointer; cdecl;
NewtonBodyGetWorld: function (const body: pNewtonBody): PNewtonWorld; cdecl;
NewtonBodyGetCollision: function (const body: pNewtonBody): PNewtonCollision; cdecl;
NewtonBodyGetMaterialGroupID: function (const body: pNewtonBody): Integer; cdecl;
NewtonBodyGetSerializedID: function (const body: pNewtonBody): Integer; cdecl;
NewtonBodyGetContinuousCollisionMode: function (const body: pNewtonBody): Integer; cdecl;
NewtonBodyGetJointRecursiveCollision: function (const body: pNewtonBody): Integer; cdecl;
NewtonBodyGetPosition: procedure (const body: pNewtonBody; const pos: pfloat); cdecl;
NewtonBodyGetMatrix: procedure (const body: pNewtonBody; const matrix: pfloat); cdecl;
NewtonBodyGetRotation: procedure (const body: pNewtonBody; const rotation: pfloat); cdecl;
NewtonBodyGetMass: procedure (const body: pNewtonBody; mass: pfloat; const Ixx: pfloat; const Iyy: pfloat; const Izz: pfloat); cdecl;
NewtonBodyGetInvMass: procedure (const body: pNewtonBody; const invMass: pfloat; const invIxx: pfloat; const invIyy: pfloat; const invIzz: pfloat); cdecl;
NewtonBodyGetInertiaMatrix: procedure (const body: pNewtonBody; const inertiaMatrix: pfloat); cdecl;
NewtonBodyGetInvInertiaMatrix: procedure (const body: pNewtonBody; const invInertiaMatrix: pfloat); cdecl;
NewtonBodyGetOmega: procedure (const body: pNewtonBody; const vector: pfloat); cdecl;
NewtonBodyGetVelocity: procedure (const body: pNewtonBody; const vector: pfloat); cdecl;
NewtonBodyGetAlpha: procedure (const body: pNewtonBody; const vector: pfloat); cdecl;
NewtonBodyGetAcceleration: procedure (const body: pNewtonBody; const vector: pfloat); cdecl;
NewtonBodyGetForce: procedure (const body: pNewtonBody; const vector: pfloat); cdecl;
NewtonBodyGetTorque: procedure (const body: pNewtonBody; const vector: pfloat); cdecl;
NewtonBodyGetCentreOfMass: procedure (const body: pNewtonBody; const com: pfloat); cdecl;
NewtonBodyGetPointVelocity: procedure (const body: pNewtonBody; const point: pfloat; const velocOut: pfloat); cdecl;
NewtonBodyApplyImpulsePair: procedure (const body: pNewtonBody; const linearImpulse: pfloat; const angularImpulse: pfloat; timestep: dfloat); cdecl;
NewtonBodyAddImpulse: procedure (const body: pNewtonBody; const pointDeltaVeloc: pfloat; const pointPosit: pfloat; timestep: dfloat); cdecl;
NewtonBodyApplyImpulseArray: procedure (const body: pNewtonBody; impuleCount: Integer; strideInByte: Integer; const impulseArray: pfloat; const pointArray: pfloat; timestep: dfloat); cdecl;
NewtonBodyIntegrateVelocity: procedure (const body: pNewtonBody; timestep: dfloat); cdecl;
NewtonBodyGetLinearDamping: function (const body: pNewtonBody): dfloat; cdecl;
NewtonBodyGetAngularDamping: procedure (const body: pNewtonBody; const vector: pfloat); cdecl;
NewtonBodyGetAABB: procedure (const body: pNewtonBody; const p0: pfloat; const p1: pfloat); cdecl;
NewtonBodyGetFirstJoint: function (const body: pNewtonBody): PNewtonJoint; cdecl;
NewtonBodyGetNextJoint: function (const body: pNewtonBody; const joint: PNewtonJoint): PNewtonJoint; cdecl;
NewtonBodyGetFirstContactJoint: function (const body: pNewtonBody): PNewtonJoint; cdecl;
NewtonBodyGetNextContactJoint: function (const body: pNewtonBody; const contactJoint: PNewtonJoint): PNewtonJoint; cdecl;
NewtonBodyFindContact: function (const body0: pNewtonBody; const body1: pNewtonBody): PNewtonJoint; cdecl;
{ contact joints interface }
NewtonContactJointGetFirstContact: function (const contactJoint: PNewtonJoint): Pointer; cdecl;
NewtonContactJointGetNextContact: function (const contactJoint: PNewtonJoint; const contact: Pointer): Pointer; cdecl;
NewtonContactJointGetContactCount: function (const contactJoint: PNewtonJoint): Integer; cdecl;
NewtonContactJointRemoveContact: procedure (const contactJoint: PNewtonJoint; const contact: Pointer); cdecl;
NewtonContactJointGetClosestDistance: function (const contactJoint: PNewtonJoint): dfloat; cdecl;
NewtonContactJointResetSelftJointCollision: procedure (const contactJoint: PNewtonJoint); cdecl;
NewtonContactJointResetIntraJointCollision: procedure (const contactJoint: PNewtonJoint); cdecl;
NewtonContactGetMaterial: function (const contact: Pointer): PNewtonMaterial; cdecl;
NewtonContactGetCollision0: function (const contact: Pointer): PNewtonCollision; cdecl;
NewtonContactGetCollision1: function (const contact: Pointer): PNewtonCollision; cdecl;
NewtonContactGetCollisionID0: function (const contact: Pointer): Pointer; cdecl;
NewtonContactGetCollisionID1: function (const contact: Pointer): Pointer; cdecl;
{ Common joint functions }
NewtonJointGetUserData: function (const joint: PNewtonJoint): Pointer; cdecl;
NewtonJointSetUserData: procedure (const joint: PNewtonJoint; const userData: Pointer); cdecl;
NewtonJointGetBody0: function (const joint: PNewtonJoint): pNewtonBody; cdecl;
NewtonJointGetBody1: function (const joint: PNewtonJoint): pNewtonBody; cdecl;
NewtonJointGetInfo: procedure (const joint: PNewtonJoint; const info: PNewtonJointRecord); cdecl;
NewtonJointGetCollisionState: function (const joint: PNewtonJoint): Integer; cdecl;
NewtonJointSetCollisionState: procedure (const joint: PNewtonJoint; state: Integer); cdecl;
NewtonJointGetStiffness: function (const joint: PNewtonJoint): dfloat; cdecl;
NewtonJointSetStiffness: procedure (const joint: PNewtonJoint; state: dfloat); cdecl;
NewtonDestroyJoint: procedure (const newtonWorld: PNewtonWorld; const joint: PNewtonJoint); cdecl;
NewtonJointSetDestructor: procedure (const joint: PNewtonJoint; destructorparam: NewtonConstraintDestructor); cdecl;
NewtonJointIsActive: function (const joint: PNewtonJoint): Integer; cdecl;
{ particle system interface (soft bodies, individual, pressure bodies and cloth) }
NewtonCreateMassSpringDamperSystem: function (const newtonWorld: PNewtonWorld; shapeID: Integer; const points: pfloat; pointCount: Integer; strideInBytes: Integer; const pointMass: pfloat; const links: Pinteger; linksCount: Integer; const linksSpring: pfloat; const linksDamper: pfloat): PNewtonCollision; cdecl;
NewtonCreateDeformableSolid: function (const newtonWorld: PNewtonWorld; const mesh: PNewtonMesh; shapeID: Integer): PNewtonCollision; cdecl;
NewtonDeformableMeshGetParticleCount: function (const deformableMesh: PNewtonCollision): Integer; cdecl;
NewtonDeformableMeshGetParticleStrideInBytes: function (const deformableMesh: PNewtonCollision): Integer; cdecl;
NewtonDeformableMeshGetParticleArray: function (const deformableMesh: PNewtonCollision): pfloat; cdecl;
{ Ball and Socket joint functions }
NewtonConstraintCreateBall: function (const newtonWorld: PNewtonWorld; const pivotPoint: pfloat; const childBody: pNewtonBody; const parentBody: pNewtonBody): PNewtonJoint; cdecl;
NewtonBallSetUserCallback: procedure (const ball: PNewtonJoint; callback: NewtonBallCallback); cdecl;
NewtonBallGetJointAngle: procedure (const ball: PNewtonJoint; angle: pfloat); cdecl;
NewtonBallGetJointOmega: procedure (const ball: PNewtonJoint; omega: pfloat); cdecl;
NewtonBallGetJointForce: procedure (const ball: PNewtonJoint; const force: pfloat); cdecl;
NewtonBallSetConeLimits: procedure (const ball: PNewtonJoint; const pin: pfloat; maxConeAngle: dfloat; maxTwistAngle: dfloat); cdecl;
{ Hinge joint functions }
NewtonConstraintCreateHinge: function (const newtonWorld: PNewtonWorld; const pivotPoint: pfloat; const pinDir: pfloat; const childBody: pNewtonBody; const parentBody: pNewtonBody): PNewtonJoint; cdecl;
NewtonHingeSetUserCallback: procedure (const hinge: PNewtonJoint; callback: NewtonHingeCallback); cdecl;
NewtonHingeGetJointAngle: function (const hinge: PNewtonJoint): dfloat; cdecl;
NewtonHingeGetJointOmega: function (const hinge: PNewtonJoint): dfloat; cdecl;
NewtonHingeGetJointForce: procedure (const hinge: PNewtonJoint; const force: pfloat); cdecl;
NewtonHingeCalculateStopAlpha: function (const hinge: PNewtonJoint; const desc: PNewtonHingeSliderUpdateDesc; angle: dfloat): dfloat; cdecl;
{ Slider joint functions }
NewtonConstraintCreateSlider: function (const newtonWorld: PNewtonWorld; const pivotPoint: pfloat; const pinDir: pfloat; const childBody: pNewtonBody; const parentBody: pNewtonBody): PNewtonJoint; cdecl;
NewtonSliderSetUserCallback: procedure (const slider: PNewtonJoint; callback: NewtonSliderCallback); cdecl;
NewtonSliderGetJointPosit: function (const slider: PNewtonJoint): dfloat; cdecl;
NewtonSliderGetJointVeloc: function (const slider: PNewtonJoint): dfloat; cdecl;
NewtonSliderGetJointForce: procedure (const slider: PNewtonJoint; const force: pfloat); cdecl;
NewtonSliderCalculateStopAccel: function (const slider: PNewtonJoint; const desc: PNewtonHingeSliderUpdateDesc; position: dfloat): dfloat; cdecl;
{ Corkscrew joint functions }
NewtonConstraintCreateCorkscrew: function (const newtonWorld: PNewtonWorld; const pivotPoint: pfloat; const pinDir: pfloat; const childBody: pNewtonBody; const parentBody: pNewtonBody): PNewtonJoint; cdecl;
NewtonCorkscrewSetUserCallback: procedure (const corkscrew: PNewtonJoint; callback: NewtonCorkscrewCallback); cdecl;
NewtonCorkscrewGetJointPosit: function (const corkscrew: PNewtonJoint): dfloat; cdecl;
NewtonCorkscrewGetJointAngle: function (const corkscrew: PNewtonJoint): dfloat; cdecl;
NewtonCorkscrewGetJointVeloc: function (const corkscrew: PNewtonJoint): dfloat; cdecl;
NewtonCorkscrewGetJointOmega: function (const corkscrew: PNewtonJoint): dfloat; cdecl;
NewtonCorkscrewGetJointForce: procedure (const corkscrew: PNewtonJoint; const force: pfloat); cdecl;
NewtonCorkscrewCalculateStopAlpha: function (const corkscrew: PNewtonJoint; const desc: PNewtonHingeSliderUpdateDesc; angle: dfloat): dfloat; cdecl;
NewtonCorkscrewCalculateStopAccel: function (const corkscrew: PNewtonJoint; const desc: PNewtonHingeSliderUpdateDesc; position: dfloat): dfloat; cdecl;
{ Universal joint functions }
NewtonConstraintCreateUniversal: function (const newtonWorld: PNewtonWorld; const pivotPoint: pfloat; const pinDir0: pfloat; const pinDir1: pfloat; const childBody: pNewtonBody; const parentBody: pNewtonBody): PNewtonJoint; cdecl;
NewtonUniversalSetUserCallback: procedure (const universal: PNewtonJoint; callback: NewtonUniversalCallback); cdecl;
NewtonUniversalGetJointAngle0: function (const universal: PNewtonJoint): dfloat; cdecl;
NewtonUniversalGetJointAngle1: function (const universal: PNewtonJoint): dfloat; cdecl;
NewtonUniversalGetJointOmega0: function (const universal: PNewtonJoint): dfloat; cdecl;
NewtonUniversalGetJointOmega1: function (const universal: PNewtonJoint): dfloat; cdecl;
NewtonUniversalGetJointForce: procedure (const universal: PNewtonJoint; const force: pfloat); cdecl;
NewtonUniversalCalculateStopAlpha0: function (const universal: PNewtonJoint; const desc: PNewtonHingeSliderUpdateDesc; angle: dfloat): dfloat; cdecl;
NewtonUniversalCalculateStopAlpha1: function (const universal: PNewtonJoint; const desc: PNewtonHingeSliderUpdateDesc; angle: dfloat): dfloat; cdecl;
{ Up vector joint functions }
NewtonConstraintCreateUpVector: function (const newtonWorld: PNewtonWorld; const pinDir: pfloat; const body: pNewtonBody): PNewtonJoint; cdecl;
NewtonUpVectorGetPin: procedure (const upVector: PNewtonJoint; pin: dfloat); cdecl;
NewtonUpVectorSetPin: procedure (const upVector: PNewtonJoint; const pin: dfloat); cdecl;
{ User defined bilateral Joint }
NewtonConstraintCreateUserJoint: function (const newtonWorld: PNewtonWorld; maxDOF: Integer; callback: NewtonUserBilateralCallback; const childBody: pNewtonBody; const parentBody: pNewtonBody): PNewtonJoint; cdecl;
NewtonUserJointGetSolverModel: function (const joint: PNewtonJoint): Integer; cdecl;
NewtonUserJointSetSolverModel: procedure (const joint: PNewtonJoint; model: Integer); cdecl;
NewtonUserJointMassScale: procedure (const joint: PNewtonJoint; scaleBody0: dfloat; scaleBody1: dfloat); cdecl;
NewtonUserJointSetFeedbackCollectorCallback: procedure (const joint: PNewtonJoint; getFeedback: NewtonUserBilateralCallback); cdecl;
NewtonUserJointAddLinearRow: procedure (const joint: PNewtonJoint; const pivot0: pfloat; const pivot1: pfloat; const dir: pfloat); cdecl;
NewtonUserJointAddAngularRow: procedure (const joint: PNewtonJoint; relativeAngle: dfloat; const dir: pfloat); cdecl;
NewtonUserJointAddGeneralRow: procedure (const joint: PNewtonJoint; const jacobian0: pfloat; const jacobian1: pfloat); cdecl;
NewtonUserJointSetRowMinimumFriction: procedure (const joint: PNewtonJoint; friction: dfloat); cdecl;
NewtonUserJointSetRowMaximumFriction: procedure (const joint: PNewtonJoint; friction: dfloat); cdecl;
NewtonUserJointCalculateRowZeroAcceleration: function (const joint: PNewtonJoint): dfloat; cdecl;
NewtonUserJointGetRowAcceleration: function (const joint: PNewtonJoint): dfloat; cdecl;
NewtonUserJointGetRowJacobian: procedure (const joint: PNewtonJoint; const linear0: pfloat; const angula0: pfloat; const linear1: pfloat; const angula1: pfloat); cdecl;
NewtonUserJointSetRowAcceleration: procedure (const joint: PNewtonJoint; acceleration: dfloat); cdecl;
NewtonUserJointSetRowSpringDamperAcceleration: procedure (const joint: PNewtonJoint; rowStiffness: dfloat; spring: dfloat; damper: dfloat); cdecl;
NewtonUserJointSetRowStiffness: procedure (const joint: PNewtonJoint; stiffness: dfloat); cdecl;
NewtonUserJoinRowsCount: function (const joint: PNewtonJoint): Integer; cdecl;
NewtonUserJointGetGeneralRow: procedure (const joint: PNewtonJoint; index: Integer; const jacobian0: pfloat; const jacobian1: pfloat); cdecl;
NewtonUserJointGetRowForce: function (const joint: PNewtonJoint; row: Integer): dfloat; cdecl;
{ Mesh joint functions }
NewtonMeshCreate: function (const newtonWorld: PNewtonWorld): PNewtonMesh; cdecl;
NewtonMeshCreateFromMesh: function (const mesh: PNewtonMesh): PNewtonMesh; cdecl;
NewtonMeshCreateFromCollision: function (const collision: PNewtonCollision): PNewtonMesh; cdecl;
NewtonMeshCreateTetrahedraIsoSurface: function (const mesh: PNewtonMesh): PNewtonMesh; cdecl;
NewtonMeshCreateConvexHull: function (const newtonWorld: PNewtonWorld; pointCount: Integer; const vertexCloud: pfloat; strideInBytes: Integer; tolerance: dfloat): PNewtonMesh; cdecl;
NewtonMeshCreateVoronoiConvexDecomposition: function (const newtonWorld: PNewtonWorld; pointCount: Integer; const vertexCloud: pfloat; strideInBytes: Integer; materialID: Integer; const textureMatrix: pfloat): PNewtonMesh; cdecl;
NewtonMeshCreateFromSerialization: function (const newtonWorld: PNewtonWorld; deserializeFunction: NewtonDeserializeCallback; const serializeHandle: Pointer): PNewtonMesh; cdecl;
NewtonMeshDestroy: procedure (const mesh: PNewtonMesh); cdecl;
NewtonMeshSerialize: procedure (const mesh: PNewtonMesh; serializeFunction: NewtonSerializeCallback; const serializeHandle: Pointer); cdecl;
NewtonMeshSaveOFF: procedure (const mesh: PNewtonMesh; const filename: pchar); cdecl;
NewtonMeshLoadOFF: function (const newtonWorld: PNewtonWorld; const filename: pchar): PNewtonMesh; cdecl;
NewtonMeshLoadTetrahedraMesh: function (const newtonWorld: PNewtonWorld; const filename: pchar): PNewtonMesh; cdecl;
NewtonMeshFlipWinding: procedure (const mesh: PNewtonMesh); cdecl;
NewtonMeshApplyTransform: procedure (const mesh: PNewtonMesh; const matrix: pfloat); cdecl;
NewtonMeshCalculateOOBB: procedure (const mesh: PNewtonMesh; const matrix: pfloat; const x: pfloat; const y: pfloat; const z: pfloat); cdecl;
NewtonMeshCalculateVertexNormals: procedure (const mesh: PNewtonMesh; angleInRadians: dfloat); cdecl;
NewtonMeshApplySphericalMapping: procedure (const mesh: PNewtonMesh; material: Integer; const aligmentMatrix: pfloat); cdecl;
NewtonMeshApplyCylindricalMapping: procedure (const mesh: PNewtonMesh; cylinderMaterial: Integer; capMaterial: Integer; const aligmentMatrix: pfloat); cdecl;
NewtonMeshApplyBoxMapping: procedure (const mesh: PNewtonMesh; frontMaterial: Integer; sideMaterial: Integer; topMaterial: Integer; const aligmentMatrix: pfloat); cdecl;
NewtonMeshApplyAngleBasedMapping: procedure (const mesh: PNewtonMesh; material: Integer; reportPrograssCallback: NewtonReportProgress; const reportPrgressUserData: Pointer; const aligmentMatrix: pfloat); cdecl;
NewtonCreateTetrahedraLinearBlendSkinWeightsChannel: procedure (const tetrahedraMesh: PNewtonMesh; const skinMesh: PNewtonMesh); cdecl;
NewtonMeshOptimize: procedure (const mesh: PNewtonMesh); cdecl;
NewtonMeshOptimizePoints: procedure (const mesh: PNewtonMesh); cdecl;
NewtonMeshOptimizeVertex: procedure (const mesh: PNewtonMesh); cdecl;
NewtonMeshIsOpenMesh: function (const mesh: PNewtonMesh): Integer; cdecl;
NewtonMeshFixTJoints: procedure (const mesh: PNewtonMesh); cdecl;
NewtonMeshPolygonize: procedure (const mesh: PNewtonMesh); cdecl;
NewtonMeshTriangulate: procedure (const mesh: PNewtonMesh); cdecl;
NewtonMeshUnion: function (const mesh: PNewtonMesh; const clipper: PNewtonMesh; const clipperMatrix: pfloat): PNewtonMesh; cdecl;
NewtonMeshDifference: function (const mesh: PNewtonMesh; const clipper: PNewtonMesh; const clipperMatrix: pfloat): PNewtonMesh; cdecl;
NewtonMeshIntersection: function (const mesh: PNewtonMesh; const clipper: PNewtonMesh; const clipperMatrix: pfloat): PNewtonMesh; cdecl;
NewtonMeshClip: procedure (const mesh: PNewtonMesh; const clipper: PNewtonMesh; const clipperMatrix: pfloat; const topMesh: PNewtonMesh; const bottomMesh: PNewtonMesh); cdecl;
NewtonMeshConvexMeshIntersection: function (const mesh: PNewtonMesh; const convexMesh: PNewtonMesh): PNewtonMesh; cdecl;
NewtonMeshSimplify: function (const mesh: PNewtonMesh; maxVertexCount: Integer; reportPrograssCallback: NewtonReportProgress; const reportPrgressUserData: Pointer): PNewtonMesh; cdecl;
NewtonMeshApproximateConvexDecomposition: function (const mesh: PNewtonMesh; maxConcavity: dfloat; backFaceDistanceFactor: dfloat; maxCount: Integer; maxVertexPerHull: Integer; reportProgressCallback: NewtonReportProgress; const reportProgressUserData: Pointer): PNewtonMesh; cdecl;
NewtonRemoveUnusedVertices: procedure (const mesh: PNewtonMesh; const vertexRemapTable: Pinteger); cdecl;
NewtonMeshBeginBuild: procedure (const mesh: PNewtonMesh); cdecl;
NewtonMeshBeginFace: procedure (const mesh: PNewtonMesh); cdecl;
NewtonMeshAddPoint: procedure (const mesh: PNewtonMesh; x: double; y: double; z: double); cdecl;
NewtonMeshAddLayer: procedure (const mesh: PNewtonMesh; layerIndex: Integer); cdecl;
NewtonMeshAddMaterial: procedure (const mesh: PNewtonMesh; materialIndex: Integer); cdecl;
NewtonMeshAddNormal: procedure (const mesh: PNewtonMesh; x: dfloat; y: dfloat; z: dfloat); cdecl;
NewtonMeshAddBinormal: procedure (const mesh: PNewtonMesh; x: dfloat; y: dfloat; z: dfloat); cdecl;
NewtonMeshAddUV0: procedure (const mesh: PNewtonMesh; u: dfloat; v: dfloat); cdecl;
NewtonMeshAddUV1: procedure (const mesh: PNewtonMesh; u: dfloat; v: dfloat); cdecl;
NewtonMeshAddVertexColor: procedure (const mesh: PNewtonMesh; r: Single; g: Single; b: Single; a: Single); cdecl;
NewtonMeshEndFace: procedure (const mesh: PNewtonMesh); cdecl;
NewtonMeshEndBuild: procedure (const mesh: PNewtonMesh); cdecl;
NewtonMeshClearVertexFormat: procedure (const format: PNewtonMeshVertexFormat); cdecl;
NewtonMeshBuildFromVertexListIndexList: procedure (const mesh: PNewtonMesh; const format: PNewtonMeshVertexFormat); cdecl;
NewtonMeshGetPointCount: function (const mesh: PNewtonMesh): Integer; cdecl;
NewtonMeshGetIndexToVertexMap: function (const mesh: PNewtonMesh): Pinteger; cdecl;
NewtonMeshGetVertexDoubleChannel: procedure (const mesh: PNewtonMesh; vertexStrideInByte: Integer; const outBuffer: Pdouble); cdecl;
NewtonMeshGetVertexChannel: procedure (const mesh: PNewtonMesh; vertexStrideInByte: Integer; const outBuffer: pfloat); cdecl;
NewtonMeshGetNormalChannel: procedure (const mesh: PNewtonMesh; vertexStrideInByte: Integer; const outBuffer: pfloat); cdecl;
NewtonMeshGetBinormalChannel: procedure (const mesh: PNewtonMesh; vertexStrideInByte: Integer; const outBuffer: pfloat); cdecl;
NewtonMeshGetUV0Channel: procedure (const mesh: PNewtonMesh; vertexStrideInByte: Integer; const outBuffer: pfloat); cdecl;
NewtonMeshGetUV1Channel: procedure (const mesh: PNewtonMesh; vertexStrideInByte: Integer; const outBuffer: pfloat); cdecl;
NewtonMeshGetVertexColorChannel: procedure (const mesh: PNewtonMesh; vertexStrideInByte: Integer; const outBuffer: pfloat); cdecl;
NewtonMeshHasNormalChannel: function (const mesh: PNewtonMesh): Integer; cdecl;
NewtonMeshHasBinormalChannel: function (const mesh: PNewtonMesh): Integer; cdecl;
NewtonMeshHasUV0Channel: function (const mesh: PNewtonMesh): Integer; cdecl;
NewtonMeshHasUV1Channel: function (const mesh: PNewtonMesh): Integer; cdecl;
NewtonMeshHasVertexColorChannel: function (const mesh: PNewtonMesh): Integer; cdecl;
NewtonMeshBeginHandle: function (const mesh: PNewtonMesh): Pointer; cdecl;
NewtonMeshEndHandle: procedure (const mesh: PNewtonMesh; const handle: Pointer); cdecl;
NewtonMeshFirstMaterial: function (const mesh: PNewtonMesh; const handle: Pointer): Integer; cdecl;
NewtonMeshNextMaterial: function (const mesh: PNewtonMesh; const handle: Pointer; materialId: Integer): Integer; cdecl;
NewtonMeshMaterialGetMaterial: function (const mesh: PNewtonMesh; const handle: Pointer; materialId: Integer): Integer; cdecl;
NewtonMeshMaterialGetIndexCount: function (const mesh: PNewtonMesh; const handle: Pointer; materialId: Integer): Integer; cdecl;
NewtonMeshMaterialGetIndexStream: procedure (const mesh: PNewtonMesh; const handle: Pointer; materialId: Integer; const index: Pinteger); cdecl;
NewtonMeshMaterialGetIndexStreamShort: procedure (const mesh: PNewtonMesh; const handle: Pointer; materialId: Integer; const index: SmallInt); cdecl;
NewtonMeshCreateFirstSingleSegment: function (const mesh: PNewtonMesh): PNewtonMesh; cdecl;
NewtonMeshCreateNextSingleSegment: function (const mesh: PNewtonMesh; const segment: PNewtonMesh): PNewtonMesh; cdecl;
NewtonMeshCreateFirstLayer: function (const mesh: PNewtonMesh): PNewtonMesh; cdecl;
NewtonMeshCreateNextLayer: function (const mesh: PNewtonMesh; const segment: PNewtonMesh): PNewtonMesh; cdecl;
NewtonMeshGetTotalFaceCount: function (const mesh: PNewtonMesh): Integer; cdecl;
NewtonMeshGetTotalIndexCount: function (const mesh: PNewtonMesh): Integer; cdecl;
NewtonMeshGetFaces: procedure (const mesh: PNewtonMesh; const faceIndexCount: Pinteger; const faceMaterial: Pinteger; const faceIndices: PPointer); cdecl;
NewtonMeshGetVertexCount: function (const mesh: PNewtonMesh): Integer; cdecl;
NewtonMeshGetVertexStrideInByte: function (const mesh: PNewtonMesh): Integer; cdecl;
NewtonMeshGetVertexArray: function (const mesh: PNewtonMesh): Pdouble; cdecl;
NewtonMeshGetVertexBaseCount: function (const mesh: PNewtonMesh): Integer; cdecl;
NewtonMeshSetVertexBaseCount: procedure (const mesh: PNewtonMesh; baseCount: Integer); cdecl;
NewtonMeshGetFirstVertex: function (const mesh: PNewtonMesh): Pointer; cdecl;
NewtonMeshGetNextVertex: function (const mesh: PNewtonMesh; const vertex: Pointer): Pointer; cdecl;
NewtonMeshGetVertexIndex: function (const mesh: PNewtonMesh; const vertex: Pointer): Integer; cdecl;
NewtonMeshGetFirstPoint: function (const mesh: PNewtonMesh): Pointer; cdecl;
NewtonMeshGetNextPoint: function (const mesh: PNewtonMesh; const point: Pointer): Pointer; cdecl;
NewtonMeshGetPointIndex: function (const mesh: PNewtonMesh; const point: Pointer): Integer; cdecl;
NewtonMeshGetVertexIndexFromPoint: function (const mesh: PNewtonMesh; const point: Pointer): Integer; cdecl;
NewtonMeshGetFirstEdge: function (const mesh: PNewtonMesh): Pointer; cdecl;
NewtonMeshGetNextEdge: function (const mesh: PNewtonMesh; const edge: Pointer): Pointer; cdecl;
NewtonMeshGetEdgeIndices: procedure (const mesh: PNewtonMesh; const edge: Pointer; const v0: Pinteger; const v1: Pinteger); cdecl;
NewtonMeshGetFirstFace: function (const mesh: PNewtonMesh): Pointer; cdecl;
NewtonMeshGetNextFace: function (const mesh: PNewtonMesh; const face: Pointer): Pointer; cdecl;
NewtonMeshIsFaceOpen: function (const mesh: PNewtonMesh; const face: Pointer): Integer; cdecl;
NewtonMeshGetFaceMaterial: function (const mesh: PNewtonMesh; const face: Pointer): Integer; cdecl;
NewtonMeshGetFaceIndexCount: function (const mesh: PNewtonMesh; const face: Pointer): Integer; cdecl;
NewtonMeshGetFaceIndices: procedure (const mesh: PNewtonMesh; const face: Pointer; const indices: Pinteger); cdecl;
NewtonMeshGetFacePointIndices: procedure (const mesh: PNewtonMesh; const face: Pointer; const indices: Pinteger); cdecl;
NewtonMeshCalculateFaceNormal: procedure (const mesh: PNewtonMesh; const face: Pointer; const normal: Pdouble); cdecl;
NewtonMeshSetFaceMaterial: procedure (const mesh: PNewtonMesh; const face: Pointer; matId: Integer); cdecl;

linked_functions : array[0..508] of TNewtonFuncLinkRecord = (
	( function_name: 'NewtonWorldGetVersion'; function_ptr: nil ), 
	( function_name: 'NewtonWorldFloatSize'; function_ptr: nil ), 
	( function_name: 'NewtonGetMemoryUsed'; function_ptr: nil ), 
	( function_name: 'NewtonSetMemorySystem'; function_ptr: nil ), 
	( function_name: 'NewtonCreate'; function_ptr: nil ), 
	( function_name: 'NewtonDestroy'; function_ptr: nil ), 
	( function_name: 'NewtonDestroyAllBodies'; function_ptr: nil ), 
	( function_name: 'NewtonGetPostUpdateCallback'; function_ptr: nil ), 
	( function_name: 'NewtonSetPostUpdateCallback'; function_ptr: nil ), 
	( function_name: 'NewtonAlloc'; function_ptr: nil ), 
	( function_name: 'NewtonFree'; function_ptr: nil ), 
	( function_name: 'NewtonLoadPlugins'; function_ptr: nil ), 
	( function_name: 'NewtonUnloadPlugins'; function_ptr: nil ), 
	( function_name: 'NewtonCurrentPlugin'; function_ptr: nil ), 
	( function_name: 'NewtonGetFirstPlugin'; function_ptr: nil ), 
	( function_name: 'NewtonGetPreferedPlugin'; function_ptr: nil ), 
	( function_name: 'NewtonGetNextPlugin'; function_ptr: nil ), 
	( function_name: 'NewtonGetPluginString'; function_ptr: nil ), 
	( function_name: 'NewtonSelectPlugin'; function_ptr: nil ), 
	( function_name: 'NewtonGetContactMergeTolerance'; function_ptr: nil ), 
	( function_name: 'NewtonSetContactMergeTolerance'; function_ptr: nil ), 
	( function_name: 'NewtonInvalidateCache'; function_ptr: nil ), 
	( function_name: 'NewtonSetSolverIterations'; function_ptr: nil ), 
	( function_name: 'NewtonGetSolverIterations'; function_ptr: nil ), 
	( function_name: 'NewtonSetParallelSolverOnLargeIsland'; function_ptr: nil ), 
	( function_name: 'NewtonGetParallelSolverOnLargeIsland'; function_ptr: nil ), 
	( function_name: 'NewtonGetBroadphaseAlgorithm'; function_ptr: nil ), 
	( function_name: 'NewtonSelectBroadphaseAlgorithm'; function_ptr: nil ), 
	( function_name: 'NewtonResetBroadphase'; function_ptr: nil ), 
	( function_name: 'NewtonUpdate'; function_ptr: nil ), 
	( function_name: 'NewtonUpdateAsync'; function_ptr: nil ), 
	( function_name: 'NewtonWaitForUpdateToFinish'; function_ptr: nil ), 
	( function_name: 'NewtonGetNumberOfSubsteps'; function_ptr: nil ), 
	( function_name: 'NewtonSetNumberOfSubsteps'; function_ptr: nil ), 
	( function_name: 'NewtonGetLastUpdateTime'; function_ptr: nil ), 
	( function_name: 'NewtonSerializeToFile'; function_ptr: nil ), 
	( function_name: 'NewtonDeserializeFromFile'; function_ptr: nil ), 
	( function_name: 'NewtonSerializeScene'; function_ptr: nil ), 
	( function_name: 'NewtonDeserializeScene'; function_ptr: nil ), 
	( function_name: 'NewtonFindSerializedBody'; function_ptr: nil ), 
	( function_name: 'NewtonSetJointSerializationCallbacks'; function_ptr: nil ), 
	( function_name: 'NewtonGetJointSerializationCallbacks'; function_ptr: nil ), 
	( function_name: 'NewtonWorldCriticalSectionLock'; function_ptr: nil ), 
	( function_name: 'NewtonWorldCriticalSectionUnlock'; function_ptr: nil ), 
	( function_name: 'NewtonSetThreadsCount'; function_ptr: nil ), 
	( function_name: 'NewtonGetThreadsCount'; function_ptr: nil ), 
	( function_name: 'NewtonGetMaxThreadsCount'; function_ptr: nil ), 
	( function_name: 'NewtonDispachThreadJob'; function_ptr: nil ), 
	( function_name: 'NewtonSyncThreadJobs'; function_ptr: nil ), 
	( function_name: 'NewtonAtomicAdd'; function_ptr: nil ), 
	( function_name: 'NewtonAtomicSwap'; function_ptr: nil ), 
	( function_name: 'NewtonYield'; function_ptr: nil ), 
	( function_name: 'NewtonSetIslandUpdateEvent'; function_ptr: nil ), 
	( function_name: 'NewtonWorldForEachJointDo'; function_ptr: nil ), 
	( function_name: 'NewtonWorldForEachBodyInAABBDo'; function_ptr: nil ), 
	( function_name: 'NewtonWorldSetUserData'; function_ptr: nil ), 
	( function_name: 'NewtonWorldGetUserData'; function_ptr: nil ), 
	( function_name: 'NewtonWorldAddListener'; function_ptr: nil ), 
	( function_name: 'NewtonWorldGetListener'; function_ptr: nil ), 
	( function_name: 'NewtonWorldListenerSetDebugCallback'; function_ptr: nil ), 
	( function_name: 'NewtonWorldListenerSetPostStepCallback'; function_ptr: nil ), 
	( function_name: 'NewtonWorldListenerSetPreUpdateCallback'; function_ptr: nil ), 
	( function_name: 'NewtonWorldListenerSetPostUpdateCallback'; function_ptr: nil ), 
	( function_name: 'NewtonWorldListenerSetDestructorCallback'; function_ptr: nil ), 
	( function_name: 'NewtonWorldListenerSetBodyDestroyCallback'; function_ptr: nil ), 
	( function_name: 'NewtonWorldListenerDebug'; function_ptr: nil ), 
	( function_name: 'NewtonWorldGetListenerUserData'; function_ptr: nil ), 
	( function_name: 'NewtonWorldListenerGetBodyDestroyCallback'; function_ptr: nil ), 
	( function_name: 'NewtonWorldSetDestructorCallback'; function_ptr: nil ), 
	( function_name: 'NewtonWorldGetDestructorCallback'; function_ptr: nil ), 
	( function_name: 'NewtonWorldSetCollisionConstructorDestructorCallback'; function_ptr: nil ), 
	( function_name: 'NewtonWorldSetCreateDestroyContactCallback'; function_ptr: nil ), 
	( function_name: 'NewtonWorldRayCast'; function_ptr: nil ), 
	( function_name: 'NewtonWorldConvexCast'; function_ptr: nil ), 
	( function_name: 'NewtonWorldCollide'; function_ptr: nil ), 
	( function_name: 'NewtonWorldGetBodyCount'; function_ptr: nil ), 
	( function_name: 'NewtonWorldGetConstraintCount'; function_ptr: nil ), 
	( function_name: 'NewtonWorldFindJoint'; function_ptr: nil ), 
	( function_name: 'NewtonIslandGetBody'; function_ptr: nil ), 
	( function_name: 'NewtonIslandGetBodyAABB'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialCreateGroupID'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialGetDefaultGroupID'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialDestroyAllGroupID'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialGetUserData'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialSetSurfaceThickness'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialSetCallbackUserData'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialSetContactGenerationCallback'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialSetCompoundCollisionCallback'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialSetCollisionCallback'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialSetDefaultSoftness'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialSetDefaultElasticity'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialSetDefaultCollidable'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialSetDefaultFriction'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialJointResetIntraJointCollision'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialJointResetSelftJointCollision'; function_ptr: nil ), 
	( function_name: 'NewtonWorldGetFirstMaterial'; function_ptr: nil ), 
	( function_name: 'NewtonWorldGetNextMaterial'; function_ptr: nil ), 
	( function_name: 'NewtonWorldGetFirstBody'; function_ptr: nil ), 
	( function_name: 'NewtonWorldGetNextBody'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialGetMaterialPairUserData'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialGetContactFaceAttribute'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialGetBodyCollidingShape'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialGetContactNormalSpeed'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialGetContactForce'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialGetContactPositionAndNormal'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialGetContactTangentDirections'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialGetContactTangentSpeed'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialGetContactMaxNormalImpact'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialGetContactMaxTangentImpact'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialGetContactPenetration'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialSetAsSoftContact'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialSetContactSoftness'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialSetContactThickness'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialSetContactElasticity'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialSetContactFrictionState'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialSetContactFrictionCoef'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialSetContactNormalAcceleration'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialSetContactNormalDirection'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialSetContactPosition'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialSetContactTangentFriction'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialSetContactTangentAcceleration'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialContactRotateTangentDirections'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialGetContactPruningTolerance'; function_ptr: nil ), 
	( function_name: 'NewtonMaterialSetContactPruningTolerance'; function_ptr: nil ), 
	( function_name: 'NewtonCreateNull'; function_ptr: nil ), 
	( function_name: 'NewtonCreateSphere'; function_ptr: nil ), 
	( function_name: 'NewtonCreateBox'; function_ptr: nil ), 
	( function_name: 'NewtonCreateCone'; function_ptr: nil ), 
	( function_name: 'NewtonCreateCapsule'; function_ptr: nil ), 
	( function_name: 'NewtonCreateCylinder'; function_ptr: nil ), 
	( function_name: 'NewtonCreateChamferCylinder'; function_ptr: nil ), 
	( function_name: 'NewtonCreateConvexHull'; function_ptr: nil ), 
	( function_name: 'NewtonCreateConvexHullFromMesh'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionGetMode'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionSetMode'; function_ptr: nil ), 
	( function_name: 'NewtonConvexHullGetFaceIndices'; function_ptr: nil ), 
	( function_name: 'NewtonConvexHullGetVertexData'; function_ptr: nil ), 
	( function_name: 'NewtonConvexCollisionCalculateVolume'; function_ptr: nil ), 
	( function_name: 'NewtonConvexCollisionCalculateInertialMatrix'; function_ptr: nil ), 
	( function_name: 'NewtonConvexCollisionCalculateBuoyancyVolume'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionDataPointer'; function_ptr: nil ), 
	( function_name: 'NewtonCreateCompoundCollision'; function_ptr: nil ), 
	( function_name: 'NewtonCreateCompoundCollisionFromMesh'; function_ptr: nil ), 
	( function_name: 'NewtonCompoundCollisionBeginAddRemove'; function_ptr: nil ), 
	( function_name: 'NewtonCompoundCollisionAddSubCollision'; function_ptr: nil ), 
	( function_name: 'NewtonCompoundCollisionRemoveSubCollision'; function_ptr: nil ), 
	( function_name: 'NewtonCompoundCollisionRemoveSubCollisionByIndex'; function_ptr: nil ), 
	( function_name: 'NewtonCompoundCollisionSetSubCollisionMatrix'; function_ptr: nil ), 
	( function_name: 'NewtonCompoundCollisionEndAddRemove'; function_ptr: nil ), 
	( function_name: 'NewtonCompoundCollisionGetFirstNode'; function_ptr: nil ), 
	( function_name: 'NewtonCompoundCollisionGetNextNode'; function_ptr: nil ), 
	( function_name: 'NewtonCompoundCollisionGetNodeByIndex'; function_ptr: nil ), 
	( function_name: 'NewtonCompoundCollisionGetNodeIndex'; function_ptr: nil ), 
	( function_name: 'NewtonCompoundCollisionGetCollisionFromNode'; function_ptr: nil ), 
	( function_name: 'NewtonCreateFracturedCompoundCollision'; function_ptr: nil ), 
	( function_name: 'NewtonFracturedCompoundPlaneClip'; function_ptr: nil ), 
	( function_name: 'NewtonFracturedCompoundSetCallbacks'; function_ptr: nil ), 
	( function_name: 'NewtonFracturedCompoundIsNodeFreeToDetach'; function_ptr: nil ), 
	( function_name: 'NewtonFracturedCompoundNeighborNodeList'; function_ptr: nil ), 
	( function_name: 'NewtonFracturedCompoundGetMainMesh'; function_ptr: nil ), 
	( function_name: 'NewtonFracturedCompoundGetFirstSubMesh'; function_ptr: nil ), 
	( function_name: 'NewtonFracturedCompoundGetNextSubMesh'; function_ptr: nil ), 
	( function_name: 'NewtonFracturedCompoundCollisionGetVertexCount'; function_ptr: nil ), 
	( function_name: 'NewtonFracturedCompoundCollisionGetVertexPositions'; function_ptr: nil ), 
	( function_name: 'NewtonFracturedCompoundCollisionGetVertexNormals'; function_ptr: nil ), 
	( function_name: 'NewtonFracturedCompoundCollisionGetVertexUVs'; function_ptr: nil ), 
	( function_name: 'NewtonFracturedCompoundMeshPartGetIndexStream'; function_ptr: nil ), 
	( function_name: 'NewtonFracturedCompoundMeshPartGetFirstSegment'; function_ptr: nil ), 
	( function_name: 'NewtonFracturedCompoundMeshPartGetNextSegment'; function_ptr: nil ), 
	( function_name: 'NewtonFracturedCompoundMeshPartGetMaterial'; function_ptr: nil ), 
	( function_name: 'NewtonFracturedCompoundMeshPartGetIndexCount'; function_ptr: nil ), 
	( function_name: 'NewtonCreateSceneCollision'; function_ptr: nil ), 
	( function_name: 'NewtonSceneCollisionBeginAddRemove'; function_ptr: nil ), 
	( function_name: 'NewtonSceneCollisionAddSubCollision'; function_ptr: nil ), 
	( function_name: 'NewtonSceneCollisionRemoveSubCollision'; function_ptr: nil ), 
	( function_name: 'NewtonSceneCollisionRemoveSubCollisionByIndex'; function_ptr: nil ), 
	( function_name: 'NewtonSceneCollisionSetSubCollisionMatrix'; function_ptr: nil ), 
	( function_name: 'NewtonSceneCollisionEndAddRemove'; function_ptr: nil ), 
	( function_name: 'NewtonSceneCollisionGetFirstNode'; function_ptr: nil ), 
	( function_name: 'NewtonSceneCollisionGetNextNode'; function_ptr: nil ), 
	( function_name: 'NewtonSceneCollisionGetNodeByIndex'; function_ptr: nil ), 
	( function_name: 'NewtonSceneCollisionGetNodeIndex'; function_ptr: nil ), 
	( function_name: 'NewtonSceneCollisionGetCollisionFromNode'; function_ptr: nil ), 
	( function_name: 'NewtonCreateUserMeshCollision'; function_ptr: nil ), 
	( function_name: 'NewtonUserMeshCollisionContinuousOverlapTest'; function_ptr: nil ), 
	( function_name: 'NewtonCreateCollisionFromSerialization'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionSerialize'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionGetInfo'; function_ptr: nil ), 
	( function_name: 'NewtonCreateHeightFieldCollision'; function_ptr: nil ), 
	( function_name: 'NewtonHeightFieldSetUserRayCastCallback'; function_ptr: nil ), 
	( function_name: 'NewtonCreateTreeCollision'; function_ptr: nil ), 
	( function_name: 'NewtonCreateTreeCollisionFromMesh'; function_ptr: nil ), 
	( function_name: 'NewtonTreeCollisionSetUserRayCastCallback'; function_ptr: nil ), 
	( function_name: 'NewtonTreeCollisionBeginBuild'; function_ptr: nil ), 
	( function_name: 'NewtonTreeCollisionAddFace'; function_ptr: nil ), 
	( function_name: 'NewtonTreeCollisionEndBuild'; function_ptr: nil ), 
	( function_name: 'NewtonTreeCollisionGetFaceAttribute'; function_ptr: nil ), 
	( function_name: 'NewtonTreeCollisionSetFaceAttribute'; function_ptr: nil ), 
	( function_name: 'NewtonTreeCollisionForEachFace'; function_ptr: nil ), 
	( function_name: 'NewtonTreeCollisionGetVertexListTriangleListInAABB'; function_ptr: nil ), 
	( function_name: 'NewtonStaticCollisionSetDebugCallback'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionCreateInstance'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionGetType'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionIsConvexShape'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionIsStaticShape'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionSetUserData'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionGetUserData'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionSetUserID'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionGetUserID'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionGetMaterial'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionSetMaterial'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionGetSubCollisionHandle'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionGetParentInstance'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionSetMatrix'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionGetMatrix'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionSetScale'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionGetScale'; function_ptr: nil ), 
	( function_name: 'NewtonDestroyCollision'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionGetSkinThickness'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionSetSkinThickness'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionIntersectionTest'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionPointDistance'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionClosestPoint'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionCollide'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionCollideContinue'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionSupportVertex'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionRayCast'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionCalculateAABB'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionForEachPolygonDo'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionAggregateCreate'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionAggregateDestroy'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionAggregateAddBody'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionAggregateRemoveBody'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionAggregateGetSelfCollision'; function_ptr: nil ), 
	( function_name: 'NewtonCollisionAggregateSetSelfCollision'; function_ptr: nil ), 
	( function_name: 'NewtonSetEulerAngle'; function_ptr: nil ), 
	( function_name: 'NewtonGetEulerAngle'; function_ptr: nil ), 
	( function_name: 'NewtonCalculateSpringDamperAcceleration'; function_ptr: nil ), 
	( function_name: 'NewtonCreateDynamicBody'; function_ptr: nil ), 
	( function_name: 'NewtonCreateKinematicBody'; function_ptr: nil ), 
	( function_name: 'NewtonCreateAsymetricDynamicBody'; function_ptr: nil ), 
	( function_name: 'NewtonDestroyBody'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetSimulationState'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetSimulationState'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetType'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetCollidable'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetCollidable'; function_ptr: nil ), 
	( function_name: 'NewtonBodyAddForce'; function_ptr: nil ), 
	( function_name: 'NewtonBodyAddTorque'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetCentreOfMass'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetMassMatrix'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetFullMassMatrix'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetMassProperties'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetMatrix'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetMatrixNoSleep'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetMatrixRecursive'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetMaterialGroupID'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetContinuousCollisionMode'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetJointRecursiveCollision'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetOmega'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetOmegaNoSleep'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetVelocity'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetVelocityNoSleep'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetForce'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetTorque'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetLinearDamping'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetAngularDamping'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetCollision'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetCollisionScale'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetSleepState'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetSleepState'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetAutoSleep'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetAutoSleep'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetFreezeState'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetFreezeState'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetGyroscopicTorque'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetGyroscopicTorque'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetDestructorCallback'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetDestructorCallback'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetTransformCallback'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetTransformCallback'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetForceAndTorqueCallback'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetForceAndTorqueCallback'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetID'; function_ptr: nil ), 
	( function_name: 'NewtonBodySetUserData'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetUserData'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetWorld'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetCollision'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetMaterialGroupID'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetSerializedID'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetContinuousCollisionMode'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetJointRecursiveCollision'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetPosition'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetMatrix'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetRotation'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetMass'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetInvMass'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetInertiaMatrix'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetInvInertiaMatrix'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetOmega'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetVelocity'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetAlpha'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetAcceleration'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetForce'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetTorque'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetCentreOfMass'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetPointVelocity'; function_ptr: nil ), 
	( function_name: 'NewtonBodyApplyImpulsePair'; function_ptr: nil ), 
	( function_name: 'NewtonBodyAddImpulse'; function_ptr: nil ), 
	( function_name: 'NewtonBodyApplyImpulseArray'; function_ptr: nil ), 
	( function_name: 'NewtonBodyIntegrateVelocity'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetLinearDamping'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetAngularDamping'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetAABB'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetFirstJoint'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetNextJoint'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetFirstContactJoint'; function_ptr: nil ), 
	( function_name: 'NewtonBodyGetNextContactJoint'; function_ptr: nil ), 
	( function_name: 'NewtonBodyFindContact'; function_ptr: nil ), 
	( function_name: 'NewtonContactJointGetFirstContact'; function_ptr: nil ), 
	( function_name: 'NewtonContactJointGetNextContact'; function_ptr: nil ), 
	( function_name: 'NewtonContactJointGetContactCount'; function_ptr: nil ), 
	( function_name: 'NewtonContactJointRemoveContact'; function_ptr: nil ), 
	( function_name: 'NewtonContactJointGetClosestDistance'; function_ptr: nil ), 
	( function_name: 'NewtonContactJointResetSelftJointCollision'; function_ptr: nil ), 
	( function_name: 'NewtonContactJointResetIntraJointCollision'; function_ptr: nil ), 
	( function_name: 'NewtonContactGetMaterial'; function_ptr: nil ), 
	( function_name: 'NewtonContactGetCollision0'; function_ptr: nil ), 
	( function_name: 'NewtonContactGetCollision1'; function_ptr: nil ), 
	( function_name: 'NewtonContactGetCollisionID0'; function_ptr: nil ), 
	( function_name: 'NewtonContactGetCollisionID1'; function_ptr: nil ), 
	( function_name: 'NewtonJointGetUserData'; function_ptr: nil ), 
	( function_name: 'NewtonJointSetUserData'; function_ptr: nil ), 
	( function_name: 'NewtonJointGetBody0'; function_ptr: nil ), 
	( function_name: 'NewtonJointGetBody1'; function_ptr: nil ), 
	( function_name: 'NewtonJointGetInfo'; function_ptr: nil ), 
	( function_name: 'NewtonJointGetCollisionState'; function_ptr: nil ), 
	( function_name: 'NewtonJointSetCollisionState'; function_ptr: nil ), 
	( function_name: 'NewtonJointGetStiffness'; function_ptr: nil ), 
	( function_name: 'NewtonJointSetStiffness'; function_ptr: nil ), 
	( function_name: 'NewtonDestroyJoint'; function_ptr: nil ), 
	( function_name: 'NewtonJointSetDestructor'; function_ptr: nil ), 
	( function_name: 'NewtonJointIsActive'; function_ptr: nil ), 
	( function_name: 'NewtonCreateMassSpringDamperSystem'; function_ptr: nil ), 
	( function_name: 'NewtonCreateDeformableSolid'; function_ptr: nil ), 
	( function_name: 'NewtonDeformableMeshGetParticleCount'; function_ptr: nil ), 
	( function_name: 'NewtonDeformableMeshGetParticleStrideInBytes'; function_ptr: nil ), 
	( function_name: 'NewtonDeformableMeshGetParticleArray'; function_ptr: nil ), 
	( function_name: 'NewtonConstraintCreateBall'; function_ptr: nil ), 
	( function_name: 'NewtonBallSetUserCallback'; function_ptr: nil ), 
	( function_name: 'NewtonBallGetJointAngle'; function_ptr: nil ), 
	( function_name: 'NewtonBallGetJointOmega'; function_ptr: nil ), 
	( function_name: 'NewtonBallGetJointForce'; function_ptr: nil ), 
	( function_name: 'NewtonBallSetConeLimits'; function_ptr: nil ), 
	( function_name: 'NewtonConstraintCreateHinge'; function_ptr: nil ), 
	( function_name: 'NewtonHingeSetUserCallback'; function_ptr: nil ), 
	( function_name: 'NewtonHingeGetJointAngle'; function_ptr: nil ), 
	( function_name: 'NewtonHingeGetJointOmega'; function_ptr: nil ), 
	( function_name: 'NewtonHingeGetJointForce'; function_ptr: nil ), 
	( function_name: 'NewtonHingeCalculateStopAlpha'; function_ptr: nil ), 
	( function_name: 'NewtonConstraintCreateSlider'; function_ptr: nil ), 
	( function_name: 'NewtonSliderSetUserCallback'; function_ptr: nil ), 
	( function_name: 'NewtonSliderGetJointPosit'; function_ptr: nil ), 
	( function_name: 'NewtonSliderGetJointVeloc'; function_ptr: nil ), 
	( function_name: 'NewtonSliderGetJointForce'; function_ptr: nil ), 
	( function_name: 'NewtonSliderCalculateStopAccel'; function_ptr: nil ), 
	( function_name: 'NewtonConstraintCreateCorkscrew'; function_ptr: nil ), 
	( function_name: 'NewtonCorkscrewSetUserCallback'; function_ptr: nil ), 
	( function_name: 'NewtonCorkscrewGetJointPosit'; function_ptr: nil ), 
	( function_name: 'NewtonCorkscrewGetJointAngle'; function_ptr: nil ), 
	( function_name: 'NewtonCorkscrewGetJointVeloc'; function_ptr: nil ), 
	( function_name: 'NewtonCorkscrewGetJointOmega'; function_ptr: nil ), 
	( function_name: 'NewtonCorkscrewGetJointForce'; function_ptr: nil ), 
	( function_name: 'NewtonCorkscrewCalculateStopAlpha'; function_ptr: nil ), 
	( function_name: 'NewtonCorkscrewCalculateStopAccel'; function_ptr: nil ), 
	( function_name: 'NewtonConstraintCreateUniversal'; function_ptr: nil ), 
	( function_name: 'NewtonUniversalSetUserCallback'; function_ptr: nil ), 
	( function_name: 'NewtonUniversalGetJointAngle0'; function_ptr: nil ), 
	( function_name: 'NewtonUniversalGetJointAngle1'; function_ptr: nil ), 
	( function_name: 'NewtonUniversalGetJointOmega0'; function_ptr: nil ), 
	( function_name: 'NewtonUniversalGetJointOmega1'; function_ptr: nil ), 
	( function_name: 'NewtonUniversalGetJointForce'; function_ptr: nil ), 
	( function_name: 'NewtonUniversalCalculateStopAlpha0'; function_ptr: nil ), 
	( function_name: 'NewtonUniversalCalculateStopAlpha1'; function_ptr: nil ), 
	( function_name: 'NewtonConstraintCreateUpVector'; function_ptr: nil ), 
	( function_name: 'NewtonUpVectorGetPin'; function_ptr: nil ), 
	( function_name: 'NewtonUpVectorSetPin'; function_ptr: nil ), 
	( function_name: 'NewtonConstraintCreateUserJoint'; function_ptr: nil ), 
	( function_name: 'NewtonUserJointGetSolverModel'; function_ptr: nil ), 
	( function_name: 'NewtonUserJointSetSolverModel'; function_ptr: nil ), 
	( function_name: 'NewtonUserJointMassScale'; function_ptr: nil ), 
	( function_name: 'NewtonUserJointSetFeedbackCollectorCallback'; function_ptr: nil ), 
	( function_name: 'NewtonUserJointAddLinearRow'; function_ptr: nil ), 
	( function_name: 'NewtonUserJointAddAngularRow'; function_ptr: nil ), 
	( function_name: 'NewtonUserJointAddGeneralRow'; function_ptr: nil ), 
	( function_name: 'NewtonUserJointSetRowMinimumFriction'; function_ptr: nil ), 
	( function_name: 'NewtonUserJointSetRowMaximumFriction'; function_ptr: nil ), 
	( function_name: 'NewtonUserJointCalculateRowZeroAcceleration'; function_ptr: nil ), 
	( function_name: 'NewtonUserJointGetRowAcceleration'; function_ptr: nil ), 
	( function_name: 'NewtonUserJointGetRowJacobian'; function_ptr: nil ), 
	( function_name: 'NewtonUserJointSetRowAcceleration'; function_ptr: nil ), 
	( function_name: 'NewtonUserJointSetRowSpringDamperAcceleration'; function_ptr: nil ), 
	( function_name: 'NewtonUserJointSetRowStiffness'; function_ptr: nil ), 
	( function_name: 'NewtonUserJoinRowsCount'; function_ptr: nil ), 
	( function_name: 'NewtonUserJointGetGeneralRow'; function_ptr: nil ), 
	( function_name: 'NewtonUserJointGetRowForce'; function_ptr: nil ), 
	( function_name: 'NewtonMeshCreate'; function_ptr: nil ), 
	( function_name: 'NewtonMeshCreateFromMesh'; function_ptr: nil ), 
	( function_name: 'NewtonMeshCreateFromCollision'; function_ptr: nil ), 
	( function_name: 'NewtonMeshCreateTetrahedraIsoSurface'; function_ptr: nil ), 
	( function_name: 'NewtonMeshCreateConvexHull'; function_ptr: nil ), 
	( function_name: 'NewtonMeshCreateVoronoiConvexDecomposition'; function_ptr: nil ), 
	( function_name: 'NewtonMeshCreateFromSerialization'; function_ptr: nil ), 
	( function_name: 'NewtonMeshDestroy'; function_ptr: nil ), 
	( function_name: 'NewtonMeshSerialize'; function_ptr: nil ), 
	( function_name: 'NewtonMeshSaveOFF'; function_ptr: nil ), 
	( function_name: 'NewtonMeshLoadOFF'; function_ptr: nil ), 
	( function_name: 'NewtonMeshLoadTetrahedraMesh'; function_ptr: nil ), 
	( function_name: 'NewtonMeshFlipWinding'; function_ptr: nil ), 
	( function_name: 'NewtonMeshApplyTransform'; function_ptr: nil ), 
	( function_name: 'NewtonMeshCalculateOOBB'; function_ptr: nil ), 
	( function_name: 'NewtonMeshCalculateVertexNormals'; function_ptr: nil ), 
	( function_name: 'NewtonMeshApplySphericalMapping'; function_ptr: nil ), 
	( function_name: 'NewtonMeshApplyCylindricalMapping'; function_ptr: nil ), 
	( function_name: 'NewtonMeshApplyBoxMapping'; function_ptr: nil ), 
	( function_name: 'NewtonMeshApplyAngleBasedMapping'; function_ptr: nil ), 
	( function_name: 'NewtonCreateTetrahedraLinearBlendSkinWeightsChannel'; function_ptr: nil ), 
	( function_name: 'NewtonMeshOptimize'; function_ptr: nil ), 
	( function_name: 'NewtonMeshOptimizePoints'; function_ptr: nil ), 
	( function_name: 'NewtonMeshOptimizeVertex'; function_ptr: nil ), 
	( function_name: 'NewtonMeshIsOpenMesh'; function_ptr: nil ), 
	( function_name: 'NewtonMeshFixTJoints'; function_ptr: nil ), 
	( function_name: 'NewtonMeshPolygonize'; function_ptr: nil ), 
	( function_name: 'NewtonMeshTriangulate'; function_ptr: nil ), 
	( function_name: 'NewtonMeshUnion'; function_ptr: nil ), 
	( function_name: 'NewtonMeshDifference'; function_ptr: nil ), 
	( function_name: 'NewtonMeshIntersection'; function_ptr: nil ), 
	( function_name: 'NewtonMeshClip'; function_ptr: nil ), 
	( function_name: 'NewtonMeshConvexMeshIntersection'; function_ptr: nil ), 
	( function_name: 'NewtonMeshSimplify'; function_ptr: nil ), 
	( function_name: 'NewtonMeshApproximateConvexDecomposition'; function_ptr: nil ), 
	( function_name: 'NewtonRemoveUnusedVertices'; function_ptr: nil ), 
	( function_name: 'NewtonMeshBeginBuild'; function_ptr: nil ), 
	( function_name: 'NewtonMeshBeginFace'; function_ptr: nil ), 
	( function_name: 'NewtonMeshAddPoint'; function_ptr: nil ), 
	( function_name: 'NewtonMeshAddLayer'; function_ptr: nil ), 
	( function_name: 'NewtonMeshAddMaterial'; function_ptr: nil ), 
	( function_name: 'NewtonMeshAddNormal'; function_ptr: nil ), 
	( function_name: 'NewtonMeshAddBinormal'; function_ptr: nil ), 
	( function_name: 'NewtonMeshAddUV0'; function_ptr: nil ), 
	( function_name: 'NewtonMeshAddUV1'; function_ptr: nil ), 
	( function_name: 'NewtonMeshAddVertexColor'; function_ptr: nil ), 
	( function_name: 'NewtonMeshEndFace'; function_ptr: nil ), 
	( function_name: 'NewtonMeshEndBuild'; function_ptr: nil ), 
	( function_name: 'NewtonMeshClearVertexFormat'; function_ptr: nil ), 
	( function_name: 'NewtonMeshBuildFromVertexListIndexList'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetPointCount'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetIndexToVertexMap'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetVertexDoubleChannel'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetVertexChannel'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetNormalChannel'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetBinormalChannel'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetUV0Channel'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetUV1Channel'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetVertexColorChannel'; function_ptr: nil ), 
	( function_name: 'NewtonMeshHasNormalChannel'; function_ptr: nil ), 
	( function_name: 'NewtonMeshHasBinormalChannel'; function_ptr: nil ), 
	( function_name: 'NewtonMeshHasUV0Channel'; function_ptr: nil ), 
	( function_name: 'NewtonMeshHasUV1Channel'; function_ptr: nil ), 
	( function_name: 'NewtonMeshHasVertexColorChannel'; function_ptr: nil ), 
	( function_name: 'NewtonMeshBeginHandle'; function_ptr: nil ), 
	( function_name: 'NewtonMeshEndHandle'; function_ptr: nil ), 
	( function_name: 'NewtonMeshFirstMaterial'; function_ptr: nil ), 
	( function_name: 'NewtonMeshNextMaterial'; function_ptr: nil ), 
	( function_name: 'NewtonMeshMaterialGetMaterial'; function_ptr: nil ), 
	( function_name: 'NewtonMeshMaterialGetIndexCount'; function_ptr: nil ), 
	( function_name: 'NewtonMeshMaterialGetIndexStream'; function_ptr: nil ), 
	( function_name: 'NewtonMeshMaterialGetIndexStreamShort'; function_ptr: nil ), 
	( function_name: 'NewtonMeshCreateFirstSingleSegment'; function_ptr: nil ), 
	( function_name: 'NewtonMeshCreateNextSingleSegment'; function_ptr: nil ), 
	( function_name: 'NewtonMeshCreateFirstLayer'; function_ptr: nil ), 
	( function_name: 'NewtonMeshCreateNextLayer'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetTotalFaceCount'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetTotalIndexCount'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetFaces'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetVertexCount'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetVertexStrideInByte'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetVertexArray'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetVertexBaseCount'; function_ptr: nil ), 
	( function_name: 'NewtonMeshSetVertexBaseCount'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetFirstVertex'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetNextVertex'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetVertexIndex'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetFirstPoint'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetNextPoint'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetPointIndex'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetVertexIndexFromPoint'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetFirstEdge'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetNextEdge'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetEdgeIndices'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetFirstFace'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetNextFace'; function_ptr: nil ), 
	( function_name: 'NewtonMeshIsFaceOpen'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetFaceMaterial'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetFaceIndexCount'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetFaceIndices'; function_ptr: nil ), 
	( function_name: 'NewtonMeshGetFacePointIndices'; function_ptr: nil ), 
	( function_name: 'NewtonMeshCalculateFaceNormal'; function_ptr: nil ), 
	( function_name: 'NewtonMeshSetFaceMaterial'; function_ptr: nil ) 
	);


	procedure LoadNewton(const dllpath: widestring);

implementation

procedure LoadNewton(const dllpath: widestring);
begin

	NewtonLibrary := LoadLibrary(dllpath);
	linked_functions[0].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldGetVersion');
	NewtonWorldGetVersion:= linked_functions[0].function_ptr;
	linked_functions[1].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldFloatSize');
	NewtonWorldFloatSize:= linked_functions[1].function_ptr;
	linked_functions[2].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonGetMemoryUsed');
	NewtonGetMemoryUsed:= linked_functions[2].function_ptr;
	linked_functions[3].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSetMemorySystem');
	NewtonSetMemorySystem:= linked_functions[3].function_ptr;
	linked_functions[4].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCreate');
	NewtonCreate:= linked_functions[4].function_ptr;
	linked_functions[5].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonDestroy');
	NewtonDestroy:= linked_functions[5].function_ptr;
	linked_functions[6].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonDestroyAllBodies');
	NewtonDestroyAllBodies:= linked_functions[6].function_ptr;
	linked_functions[7].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonGetPostUpdateCallback');
	NewtonGetPostUpdateCallback:= linked_functions[7].function_ptr;
	linked_functions[8].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSetPostUpdateCallback');
	NewtonSetPostUpdateCallback:= linked_functions[8].function_ptr;
	linked_functions[9].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonAlloc');
	NewtonAlloc:= linked_functions[9].function_ptr;
	linked_functions[10].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonFree');
	NewtonFree:= linked_functions[10].function_ptr;
	linked_functions[11].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonLoadPlugins');
	NewtonLoadPlugins:= linked_functions[11].function_ptr;
	linked_functions[12].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUnloadPlugins');
	NewtonUnloadPlugins:= linked_functions[12].function_ptr;
	linked_functions[13].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCurrentPlugin');
	NewtonCurrentPlugin:= linked_functions[13].function_ptr;
	linked_functions[14].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonGetFirstPlugin');
	NewtonGetFirstPlugin:= linked_functions[14].function_ptr;
	linked_functions[15].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonGetPreferedPlugin');
	NewtonGetPreferedPlugin:= linked_functions[15].function_ptr;
	linked_functions[16].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonGetNextPlugin');
	NewtonGetNextPlugin:= linked_functions[16].function_ptr;
	linked_functions[17].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonGetPluginString');
	NewtonGetPluginString:= linked_functions[17].function_ptr;
	linked_functions[18].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSelectPlugin');
	NewtonSelectPlugin:= linked_functions[18].function_ptr;
	linked_functions[19].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonGetContactMergeTolerance');
	NewtonGetContactMergeTolerance:= linked_functions[19].function_ptr;
	linked_functions[20].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSetContactMergeTolerance');
	NewtonSetContactMergeTolerance:= linked_functions[20].function_ptr;
	linked_functions[21].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonInvalidateCache');
	NewtonInvalidateCache:= linked_functions[21].function_ptr;
	linked_functions[22].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSetSolverIterations');
	NewtonSetSolverIterations:= linked_functions[22].function_ptr;
	linked_functions[23].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonGetSolverIterations');
	NewtonGetSolverIterations:= linked_functions[23].function_ptr;
	linked_functions[24].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSetParallelSolverOnLargeIsland');
	NewtonSetParallelSolverOnLargeIsland:= linked_functions[24].function_ptr;
	linked_functions[25].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonGetParallelSolverOnLargeIsland');
	NewtonGetParallelSolverOnLargeIsland:= linked_functions[25].function_ptr;
	linked_functions[26].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonGetBroadphaseAlgorithm');
	NewtonGetBroadphaseAlgorithm:= linked_functions[26].function_ptr;
	linked_functions[27].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSelectBroadphaseAlgorithm');
	NewtonSelectBroadphaseAlgorithm:= linked_functions[27].function_ptr;
	linked_functions[28].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonResetBroadphase');
	NewtonResetBroadphase:= linked_functions[28].function_ptr;
	linked_functions[29].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUpdate');
	NewtonUpdate:= linked_functions[29].function_ptr;
	linked_functions[30].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUpdateAsync');
	NewtonUpdateAsync:= linked_functions[30].function_ptr;
	linked_functions[31].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWaitForUpdateToFinish');
	NewtonWaitForUpdateToFinish:= linked_functions[31].function_ptr;
	linked_functions[32].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonGetNumberOfSubsteps');
	NewtonGetNumberOfSubsteps:= linked_functions[32].function_ptr;
	linked_functions[33].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSetNumberOfSubsteps');
	NewtonSetNumberOfSubsteps:= linked_functions[33].function_ptr;
	linked_functions[34].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonGetLastUpdateTime');
	NewtonGetLastUpdateTime:= linked_functions[34].function_ptr;
	linked_functions[35].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSerializeToFile');
	NewtonSerializeToFile:= linked_functions[35].function_ptr;
	linked_functions[36].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonDeserializeFromFile');
	NewtonDeserializeFromFile:= linked_functions[36].function_ptr;
	linked_functions[37].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSerializeScene');
	NewtonSerializeScene:= linked_functions[37].function_ptr;
	linked_functions[38].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonDeserializeScene');
	NewtonDeserializeScene:= linked_functions[38].function_ptr;
	linked_functions[39].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonFindSerializedBody');
	NewtonFindSerializedBody:= linked_functions[39].function_ptr;
	linked_functions[40].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSetJointSerializationCallbacks');
	NewtonSetJointSerializationCallbacks:= linked_functions[40].function_ptr;
	linked_functions[41].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonGetJointSerializationCallbacks');
	NewtonGetJointSerializationCallbacks:= linked_functions[41].function_ptr;
	linked_functions[42].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldCriticalSectionLock');
	NewtonWorldCriticalSectionLock:= linked_functions[42].function_ptr;
	linked_functions[43].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldCriticalSectionUnlock');
	NewtonWorldCriticalSectionUnlock:= linked_functions[43].function_ptr;
	linked_functions[44].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSetThreadsCount');
	NewtonSetThreadsCount:= linked_functions[44].function_ptr;
	linked_functions[45].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonGetThreadsCount');
	NewtonGetThreadsCount:= linked_functions[45].function_ptr;
	linked_functions[46].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonGetMaxThreadsCount');
	NewtonGetMaxThreadsCount:= linked_functions[46].function_ptr;
	linked_functions[47].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonDispachThreadJob');
	NewtonDispachThreadJob:= linked_functions[47].function_ptr;
	linked_functions[48].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSyncThreadJobs');
	NewtonSyncThreadJobs:= linked_functions[48].function_ptr;
	linked_functions[49].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonAtomicAdd');
	NewtonAtomicAdd:= linked_functions[49].function_ptr;
	linked_functions[50].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonAtomicSwap');
	NewtonAtomicSwap:= linked_functions[50].function_ptr;
	linked_functions[51].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonYield');
	NewtonYield:= linked_functions[51].function_ptr;
	linked_functions[52].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSetIslandUpdateEvent');
	NewtonSetIslandUpdateEvent:= linked_functions[52].function_ptr;
	linked_functions[53].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldForEachJointDo');
	NewtonWorldForEachJointDo:= linked_functions[53].function_ptr;
	linked_functions[54].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldForEachBodyInAABBDo');
	NewtonWorldForEachBodyInAABBDo:= linked_functions[54].function_ptr;
	linked_functions[55].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldSetUserData');
	NewtonWorldSetUserData:= linked_functions[55].function_ptr;
	linked_functions[56].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldGetUserData');
	NewtonWorldGetUserData:= linked_functions[56].function_ptr;
	linked_functions[57].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldAddListener');
	NewtonWorldAddListener:= linked_functions[57].function_ptr;
	linked_functions[58].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldGetListener');
	NewtonWorldGetListener:= linked_functions[58].function_ptr;
	linked_functions[59].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldListenerSetDebugCallback');
	NewtonWorldListenerSetDebugCallback:= linked_functions[59].function_ptr;
	linked_functions[60].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldListenerSetPostStepCallback');
	NewtonWorldListenerSetPostStepCallback:= linked_functions[60].function_ptr;
	linked_functions[61].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldListenerSetPreUpdateCallback');
	NewtonWorldListenerSetPreUpdateCallback:= linked_functions[61].function_ptr;
	linked_functions[62].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldListenerSetPostUpdateCallback');
	NewtonWorldListenerSetPostUpdateCallback:= linked_functions[62].function_ptr;
	linked_functions[63].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldListenerSetDestructorCallback');
	NewtonWorldListenerSetDestructorCallback:= linked_functions[63].function_ptr;
	linked_functions[64].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldListenerSetBodyDestroyCallback');
	NewtonWorldListenerSetBodyDestroyCallback:= linked_functions[64].function_ptr;
	linked_functions[65].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldListenerDebug');
	NewtonWorldListenerDebug:= linked_functions[65].function_ptr;
	linked_functions[66].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldGetListenerUserData');
	NewtonWorldGetListenerUserData:= linked_functions[66].function_ptr;
	linked_functions[67].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldListenerGetBodyDestroyCallback');
	NewtonWorldListenerGetBodyDestroyCallback:= linked_functions[67].function_ptr;
	linked_functions[68].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldSetDestructorCallback');
	NewtonWorldSetDestructorCallback:= linked_functions[68].function_ptr;
	linked_functions[69].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldGetDestructorCallback');
	NewtonWorldGetDestructorCallback:= linked_functions[69].function_ptr;
	linked_functions[70].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldSetCollisionConstructorDestructorCallback');
	NewtonWorldSetCollisionConstructorDestructorCallback:= linked_functions[70].function_ptr;
	linked_functions[71].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldSetCreateDestroyContactCallback');
	NewtonWorldSetCreateDestroyContactCallback:= linked_functions[71].function_ptr;
	linked_functions[72].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldRayCast');
	NewtonWorldRayCast:= linked_functions[72].function_ptr;
	linked_functions[73].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldConvexCast');
	NewtonWorldConvexCast:= linked_functions[73].function_ptr;
	linked_functions[74].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldCollide');
	NewtonWorldCollide:= linked_functions[74].function_ptr;
	linked_functions[75].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldGetBodyCount');
	NewtonWorldGetBodyCount:= linked_functions[75].function_ptr;
	linked_functions[76].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldGetConstraintCount');
	NewtonWorldGetConstraintCount:= linked_functions[76].function_ptr;
	linked_functions[77].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldFindJoint');
	NewtonWorldFindJoint:= linked_functions[77].function_ptr;
	linked_functions[78].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonIslandGetBody');
	NewtonIslandGetBody:= linked_functions[78].function_ptr;
	linked_functions[79].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonIslandGetBodyAABB');
	NewtonIslandGetBodyAABB:= linked_functions[79].function_ptr;
	linked_functions[80].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialCreateGroupID');
	NewtonMaterialCreateGroupID:= linked_functions[80].function_ptr;
	linked_functions[81].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialGetDefaultGroupID');
	NewtonMaterialGetDefaultGroupID:= linked_functions[81].function_ptr;
	linked_functions[82].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialDestroyAllGroupID');
	NewtonMaterialDestroyAllGroupID:= linked_functions[82].function_ptr;
	linked_functions[83].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialGetUserData');
	NewtonMaterialGetUserData:= linked_functions[83].function_ptr;
	linked_functions[84].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialSetSurfaceThickness');
	NewtonMaterialSetSurfaceThickness:= linked_functions[84].function_ptr;
	linked_functions[85].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialSetCallbackUserData');
	NewtonMaterialSetCallbackUserData:= linked_functions[85].function_ptr;
	linked_functions[86].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialSetContactGenerationCallback');
	NewtonMaterialSetContactGenerationCallback:= linked_functions[86].function_ptr;
	linked_functions[87].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialSetCompoundCollisionCallback');
	NewtonMaterialSetCompoundCollisionCallback:= linked_functions[87].function_ptr;
	linked_functions[88].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialSetCollisionCallback');
	NewtonMaterialSetCollisionCallback:= linked_functions[88].function_ptr;
	linked_functions[89].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialSetDefaultSoftness');
	NewtonMaterialSetDefaultSoftness:= linked_functions[89].function_ptr;
	linked_functions[90].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialSetDefaultElasticity');
	NewtonMaterialSetDefaultElasticity:= linked_functions[90].function_ptr;
	linked_functions[91].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialSetDefaultCollidable');
	NewtonMaterialSetDefaultCollidable:= linked_functions[91].function_ptr;
	linked_functions[92].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialSetDefaultFriction');
	NewtonMaterialSetDefaultFriction:= linked_functions[92].function_ptr;
	linked_functions[93].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialJointResetIntraJointCollision');
	NewtonMaterialJointResetIntraJointCollision:= linked_functions[93].function_ptr;
	linked_functions[94].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialJointResetSelftJointCollision');
	NewtonMaterialJointResetSelftJointCollision:= linked_functions[94].function_ptr;
	linked_functions[95].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldGetFirstMaterial');
	NewtonWorldGetFirstMaterial:= linked_functions[95].function_ptr;
	linked_functions[96].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldGetNextMaterial');
	NewtonWorldGetNextMaterial:= linked_functions[96].function_ptr;
	linked_functions[97].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldGetFirstBody');
	NewtonWorldGetFirstBody:= linked_functions[97].function_ptr;
	linked_functions[98].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonWorldGetNextBody');
	NewtonWorldGetNextBody:= linked_functions[98].function_ptr;
	linked_functions[99].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialGetMaterialPairUserData');
	NewtonMaterialGetMaterialPairUserData:= linked_functions[99].function_ptr;
	linked_functions[100].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialGetContactFaceAttribute');
	NewtonMaterialGetContactFaceAttribute:= linked_functions[100].function_ptr;
	linked_functions[101].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialGetBodyCollidingShape');
	NewtonMaterialGetBodyCollidingShape:= linked_functions[101].function_ptr;
	linked_functions[102].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialGetContactNormalSpeed');
	NewtonMaterialGetContactNormalSpeed:= linked_functions[102].function_ptr;
	linked_functions[103].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialGetContactForce');
	NewtonMaterialGetContactForce:= linked_functions[103].function_ptr;
	linked_functions[104].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialGetContactPositionAndNormal');
	NewtonMaterialGetContactPositionAndNormal:= linked_functions[104].function_ptr;
	linked_functions[105].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialGetContactTangentDirections');
	NewtonMaterialGetContactTangentDirections:= linked_functions[105].function_ptr;
	linked_functions[106].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialGetContactTangentSpeed');
	NewtonMaterialGetContactTangentSpeed:= linked_functions[106].function_ptr;
	linked_functions[107].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialGetContactMaxNormalImpact');
	NewtonMaterialGetContactMaxNormalImpact:= linked_functions[107].function_ptr;
	linked_functions[108].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialGetContactMaxTangentImpact');
	NewtonMaterialGetContactMaxTangentImpact:= linked_functions[108].function_ptr;
	linked_functions[109].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialGetContactPenetration');
	NewtonMaterialGetContactPenetration:= linked_functions[109].function_ptr;
	linked_functions[110].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialSetAsSoftContact');
	NewtonMaterialSetAsSoftContact:= linked_functions[110].function_ptr;
	linked_functions[111].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialSetContactSoftness');
	NewtonMaterialSetContactSoftness:= linked_functions[111].function_ptr;
	linked_functions[112].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialSetContactThickness');
	NewtonMaterialSetContactThickness:= linked_functions[112].function_ptr;
	linked_functions[113].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialSetContactElasticity');
	NewtonMaterialSetContactElasticity:= linked_functions[113].function_ptr;
	linked_functions[114].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialSetContactFrictionState');
	NewtonMaterialSetContactFrictionState:= linked_functions[114].function_ptr;
	linked_functions[115].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialSetContactFrictionCoef');
	NewtonMaterialSetContactFrictionCoef:= linked_functions[115].function_ptr;
	linked_functions[116].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialSetContactNormalAcceleration');
	NewtonMaterialSetContactNormalAcceleration:= linked_functions[116].function_ptr;
	linked_functions[117].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialSetContactNormalDirection');
	NewtonMaterialSetContactNormalDirection:= linked_functions[117].function_ptr;
	linked_functions[118].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialSetContactPosition');
	NewtonMaterialSetContactPosition:= linked_functions[118].function_ptr;
	linked_functions[119].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialSetContactTangentFriction');
	NewtonMaterialSetContactTangentFriction:= linked_functions[119].function_ptr;
	linked_functions[120].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialSetContactTangentAcceleration');
	NewtonMaterialSetContactTangentAcceleration:= linked_functions[120].function_ptr;
	linked_functions[121].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialContactRotateTangentDirections');
	NewtonMaterialContactRotateTangentDirections:= linked_functions[121].function_ptr;
	linked_functions[122].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialGetContactPruningTolerance');
	NewtonMaterialGetContactPruningTolerance:= linked_functions[122].function_ptr;
	linked_functions[123].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMaterialSetContactPruningTolerance');
	NewtonMaterialSetContactPruningTolerance:= linked_functions[123].function_ptr;
	linked_functions[124].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCreateNull');
	NewtonCreateNull:= linked_functions[124].function_ptr;
	linked_functions[125].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCreateSphere');
	NewtonCreateSphere:= linked_functions[125].function_ptr;
	linked_functions[126].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCreateBox');
	NewtonCreateBox:= linked_functions[126].function_ptr;
	linked_functions[127].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCreateCone');
	NewtonCreateCone:= linked_functions[127].function_ptr;
	linked_functions[128].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCreateCapsule');
	NewtonCreateCapsule:= linked_functions[128].function_ptr;
	linked_functions[129].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCreateCylinder');
	NewtonCreateCylinder:= linked_functions[129].function_ptr;
	linked_functions[130].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCreateChamferCylinder');
	NewtonCreateChamferCylinder:= linked_functions[130].function_ptr;
	linked_functions[131].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCreateConvexHull');
	NewtonCreateConvexHull:= linked_functions[131].function_ptr;
	linked_functions[132].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCreateConvexHullFromMesh');
	NewtonCreateConvexHullFromMesh:= linked_functions[132].function_ptr;
	linked_functions[133].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionGetMode');
	NewtonCollisionGetMode:= linked_functions[133].function_ptr;
	linked_functions[134].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionSetMode');
	NewtonCollisionSetMode:= linked_functions[134].function_ptr;
	linked_functions[135].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonConvexHullGetFaceIndices');
	NewtonConvexHullGetFaceIndices:= linked_functions[135].function_ptr;
	linked_functions[136].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonConvexHullGetVertexData');
	NewtonConvexHullGetVertexData:= linked_functions[136].function_ptr;
	linked_functions[137].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonConvexCollisionCalculateVolume');
	NewtonConvexCollisionCalculateVolume:= linked_functions[137].function_ptr;
	linked_functions[138].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonConvexCollisionCalculateInertialMatrix');
	NewtonConvexCollisionCalculateInertialMatrix:= linked_functions[138].function_ptr;
	linked_functions[139].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonConvexCollisionCalculateBuoyancyVolume');
	NewtonConvexCollisionCalculateBuoyancyVolume:= linked_functions[139].function_ptr;
	linked_functions[140].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionDataPointer');
	NewtonCollisionDataPointer:= linked_functions[140].function_ptr;
	linked_functions[141].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCreateCompoundCollision');
	NewtonCreateCompoundCollision:= linked_functions[141].function_ptr;
	linked_functions[142].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCreateCompoundCollisionFromMesh');
	NewtonCreateCompoundCollisionFromMesh:= linked_functions[142].function_ptr;
	linked_functions[143].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCompoundCollisionBeginAddRemove');
	NewtonCompoundCollisionBeginAddRemove:= linked_functions[143].function_ptr;
	linked_functions[144].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCompoundCollisionAddSubCollision');
	NewtonCompoundCollisionAddSubCollision:= linked_functions[144].function_ptr;
	linked_functions[145].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCompoundCollisionRemoveSubCollision');
	NewtonCompoundCollisionRemoveSubCollision:= linked_functions[145].function_ptr;
	linked_functions[146].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCompoundCollisionRemoveSubCollisionByIndex');
	NewtonCompoundCollisionRemoveSubCollisionByIndex:= linked_functions[146].function_ptr;
	linked_functions[147].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCompoundCollisionSetSubCollisionMatrix');
	NewtonCompoundCollisionSetSubCollisionMatrix:= linked_functions[147].function_ptr;
	linked_functions[148].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCompoundCollisionEndAddRemove');
	NewtonCompoundCollisionEndAddRemove:= linked_functions[148].function_ptr;
	linked_functions[149].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCompoundCollisionGetFirstNode');
	NewtonCompoundCollisionGetFirstNode:= linked_functions[149].function_ptr;
	linked_functions[150].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCompoundCollisionGetNextNode');
	NewtonCompoundCollisionGetNextNode:= linked_functions[150].function_ptr;
	linked_functions[151].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCompoundCollisionGetNodeByIndex');
	NewtonCompoundCollisionGetNodeByIndex:= linked_functions[151].function_ptr;
	linked_functions[152].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCompoundCollisionGetNodeIndex');
	NewtonCompoundCollisionGetNodeIndex:= linked_functions[152].function_ptr;
	linked_functions[153].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCompoundCollisionGetCollisionFromNode');
	NewtonCompoundCollisionGetCollisionFromNode:= linked_functions[153].function_ptr;
	linked_functions[154].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCreateFracturedCompoundCollision');
	NewtonCreateFracturedCompoundCollision:= linked_functions[154].function_ptr;
	linked_functions[155].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonFracturedCompoundPlaneClip');
	NewtonFracturedCompoundPlaneClip:= linked_functions[155].function_ptr;
	linked_functions[156].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonFracturedCompoundSetCallbacks');
	NewtonFracturedCompoundSetCallbacks:= linked_functions[156].function_ptr;
	linked_functions[157].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonFracturedCompoundIsNodeFreeToDetach');
	NewtonFracturedCompoundIsNodeFreeToDetach:= linked_functions[157].function_ptr;
	linked_functions[158].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonFracturedCompoundNeighborNodeList');
	NewtonFracturedCompoundNeighborNodeList:= linked_functions[158].function_ptr;
	linked_functions[159].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonFracturedCompoundGetMainMesh');
	NewtonFracturedCompoundGetMainMesh:= linked_functions[159].function_ptr;
	linked_functions[160].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonFracturedCompoundGetFirstSubMesh');
	NewtonFracturedCompoundGetFirstSubMesh:= linked_functions[160].function_ptr;
	linked_functions[161].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonFracturedCompoundGetNextSubMesh');
	NewtonFracturedCompoundGetNextSubMesh:= linked_functions[161].function_ptr;
	linked_functions[162].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonFracturedCompoundCollisionGetVertexCount');
	NewtonFracturedCompoundCollisionGetVertexCount:= linked_functions[162].function_ptr;
	linked_functions[163].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonFracturedCompoundCollisionGetVertexPositions');
	NewtonFracturedCompoundCollisionGetVertexPositions:= linked_functions[163].function_ptr;
	linked_functions[164].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonFracturedCompoundCollisionGetVertexNormals');
	NewtonFracturedCompoundCollisionGetVertexNormals:= linked_functions[164].function_ptr;
	linked_functions[165].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonFracturedCompoundCollisionGetVertexUVs');
	NewtonFracturedCompoundCollisionGetVertexUVs:= linked_functions[165].function_ptr;
	linked_functions[166].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonFracturedCompoundMeshPartGetIndexStream');
	NewtonFracturedCompoundMeshPartGetIndexStream:= linked_functions[166].function_ptr;
	linked_functions[167].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonFracturedCompoundMeshPartGetFirstSegment');
	NewtonFracturedCompoundMeshPartGetFirstSegment:= linked_functions[167].function_ptr;
	linked_functions[168].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonFracturedCompoundMeshPartGetNextSegment');
	NewtonFracturedCompoundMeshPartGetNextSegment:= linked_functions[168].function_ptr;
	linked_functions[169].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonFracturedCompoundMeshPartGetMaterial');
	NewtonFracturedCompoundMeshPartGetMaterial:= linked_functions[169].function_ptr;
	linked_functions[170].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonFracturedCompoundMeshPartGetIndexCount');
	NewtonFracturedCompoundMeshPartGetIndexCount:= linked_functions[170].function_ptr;
	linked_functions[171].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCreateSceneCollision');
	NewtonCreateSceneCollision:= linked_functions[171].function_ptr;
	linked_functions[172].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSceneCollisionBeginAddRemove');
	NewtonSceneCollisionBeginAddRemove:= linked_functions[172].function_ptr;
	linked_functions[173].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSceneCollisionAddSubCollision');
	NewtonSceneCollisionAddSubCollision:= linked_functions[173].function_ptr;
	linked_functions[174].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSceneCollisionRemoveSubCollision');
	NewtonSceneCollisionRemoveSubCollision:= linked_functions[174].function_ptr;
	linked_functions[175].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSceneCollisionRemoveSubCollisionByIndex');
	NewtonSceneCollisionRemoveSubCollisionByIndex:= linked_functions[175].function_ptr;
	linked_functions[176].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSceneCollisionSetSubCollisionMatrix');
	NewtonSceneCollisionSetSubCollisionMatrix:= linked_functions[176].function_ptr;
	linked_functions[177].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSceneCollisionEndAddRemove');
	NewtonSceneCollisionEndAddRemove:= linked_functions[177].function_ptr;
	linked_functions[178].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSceneCollisionGetFirstNode');
	NewtonSceneCollisionGetFirstNode:= linked_functions[178].function_ptr;
	linked_functions[179].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSceneCollisionGetNextNode');
	NewtonSceneCollisionGetNextNode:= linked_functions[179].function_ptr;
	linked_functions[180].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSceneCollisionGetNodeByIndex');
	NewtonSceneCollisionGetNodeByIndex:= linked_functions[180].function_ptr;
	linked_functions[181].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSceneCollisionGetNodeIndex');
	NewtonSceneCollisionGetNodeIndex:= linked_functions[181].function_ptr;
	linked_functions[182].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSceneCollisionGetCollisionFromNode');
	NewtonSceneCollisionGetCollisionFromNode:= linked_functions[182].function_ptr;
	linked_functions[183].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCreateUserMeshCollision');
	NewtonCreateUserMeshCollision:= linked_functions[183].function_ptr;
	linked_functions[184].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUserMeshCollisionContinuousOverlapTest');
	NewtonUserMeshCollisionContinuousOverlapTest:= linked_functions[184].function_ptr;
	linked_functions[185].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCreateCollisionFromSerialization');
	NewtonCreateCollisionFromSerialization:= linked_functions[185].function_ptr;
	linked_functions[186].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionSerialize');
	NewtonCollisionSerialize:= linked_functions[186].function_ptr;
	linked_functions[187].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionGetInfo');
	NewtonCollisionGetInfo:= linked_functions[187].function_ptr;
	linked_functions[188].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCreateHeightFieldCollision');
	NewtonCreateHeightFieldCollision:= linked_functions[188].function_ptr;
	linked_functions[189].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonHeightFieldSetUserRayCastCallback');
	NewtonHeightFieldSetUserRayCastCallback:= linked_functions[189].function_ptr;
	linked_functions[190].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCreateTreeCollision');
	NewtonCreateTreeCollision:= linked_functions[190].function_ptr;
	linked_functions[191].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCreateTreeCollisionFromMesh');
	NewtonCreateTreeCollisionFromMesh:= linked_functions[191].function_ptr;
	linked_functions[192].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonTreeCollisionSetUserRayCastCallback');
	NewtonTreeCollisionSetUserRayCastCallback:= linked_functions[192].function_ptr;
	linked_functions[193].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonTreeCollisionBeginBuild');
	NewtonTreeCollisionBeginBuild:= linked_functions[193].function_ptr;
	linked_functions[194].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonTreeCollisionAddFace');
	NewtonTreeCollisionAddFace:= linked_functions[194].function_ptr;
	linked_functions[195].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonTreeCollisionEndBuild');
	NewtonTreeCollisionEndBuild:= linked_functions[195].function_ptr;
	linked_functions[196].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonTreeCollisionGetFaceAttribute');
	NewtonTreeCollisionGetFaceAttribute:= linked_functions[196].function_ptr;
	linked_functions[197].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonTreeCollisionSetFaceAttribute');
	NewtonTreeCollisionSetFaceAttribute:= linked_functions[197].function_ptr;
	linked_functions[198].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonTreeCollisionForEachFace');
	NewtonTreeCollisionForEachFace:= linked_functions[198].function_ptr;
	linked_functions[199].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonTreeCollisionGetVertexListTriangleListInAABB');
	NewtonTreeCollisionGetVertexListTriangleListInAABB:= linked_functions[199].function_ptr;
	linked_functions[200].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonStaticCollisionSetDebugCallback');
	NewtonStaticCollisionSetDebugCallback:= linked_functions[200].function_ptr;
	linked_functions[201].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionCreateInstance');
	NewtonCollisionCreateInstance:= linked_functions[201].function_ptr;
	linked_functions[202].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionGetType');
	NewtonCollisionGetType:= linked_functions[202].function_ptr;
	linked_functions[203].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionIsConvexShape');
	NewtonCollisionIsConvexShape:= linked_functions[203].function_ptr;
	linked_functions[204].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionIsStaticShape');
	NewtonCollisionIsStaticShape:= linked_functions[204].function_ptr;
	linked_functions[205].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionSetUserData');
	NewtonCollisionSetUserData:= linked_functions[205].function_ptr;
	linked_functions[206].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionGetUserData');
	NewtonCollisionGetUserData:= linked_functions[206].function_ptr;
	linked_functions[207].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionSetUserID');
	NewtonCollisionSetUserID:= linked_functions[207].function_ptr;
	linked_functions[208].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionGetUserID');
	NewtonCollisionGetUserID:= linked_functions[208].function_ptr;
	linked_functions[209].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionGetMaterial');
	NewtonCollisionGetMaterial:= linked_functions[209].function_ptr;
	linked_functions[210].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionSetMaterial');
	NewtonCollisionSetMaterial:= linked_functions[210].function_ptr;
	linked_functions[211].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionGetSubCollisionHandle');
	NewtonCollisionGetSubCollisionHandle:= linked_functions[211].function_ptr;
	linked_functions[212].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionGetParentInstance');
	NewtonCollisionGetParentInstance:= linked_functions[212].function_ptr;
	linked_functions[213].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionSetMatrix');
	NewtonCollisionSetMatrix:= linked_functions[213].function_ptr;
	linked_functions[214].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionGetMatrix');
	NewtonCollisionGetMatrix:= linked_functions[214].function_ptr;
	linked_functions[215].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionSetScale');
	NewtonCollisionSetScale:= linked_functions[215].function_ptr;
	linked_functions[216].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionGetScale');
	NewtonCollisionGetScale:= linked_functions[216].function_ptr;
	linked_functions[217].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonDestroyCollision');
	NewtonDestroyCollision:= linked_functions[217].function_ptr;
	linked_functions[218].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionGetSkinThickness');
	NewtonCollisionGetSkinThickness:= linked_functions[218].function_ptr;
	linked_functions[219].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionSetSkinThickness');
	NewtonCollisionSetSkinThickness:= linked_functions[219].function_ptr;
	linked_functions[220].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionIntersectionTest');
	NewtonCollisionIntersectionTest:= linked_functions[220].function_ptr;
	linked_functions[221].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionPointDistance');
	NewtonCollisionPointDistance:= linked_functions[221].function_ptr;
	linked_functions[222].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionClosestPoint');
	NewtonCollisionClosestPoint:= linked_functions[222].function_ptr;
	linked_functions[223].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionCollide');
	NewtonCollisionCollide:= linked_functions[223].function_ptr;
	linked_functions[224].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionCollideContinue');
	NewtonCollisionCollideContinue:= linked_functions[224].function_ptr;
	linked_functions[225].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionSupportVertex');
	NewtonCollisionSupportVertex:= linked_functions[225].function_ptr;
	linked_functions[226].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionRayCast');
	NewtonCollisionRayCast:= linked_functions[226].function_ptr;
	linked_functions[227].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionCalculateAABB');
	NewtonCollisionCalculateAABB:= linked_functions[227].function_ptr;
	linked_functions[228].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionForEachPolygonDo');
	NewtonCollisionForEachPolygonDo:= linked_functions[228].function_ptr;
	linked_functions[229].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionAggregateCreate');
	NewtonCollisionAggregateCreate:= linked_functions[229].function_ptr;
	linked_functions[230].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionAggregateDestroy');
	NewtonCollisionAggregateDestroy:= linked_functions[230].function_ptr;
	linked_functions[231].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionAggregateAddBody');
	NewtonCollisionAggregateAddBody:= linked_functions[231].function_ptr;
	linked_functions[232].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionAggregateRemoveBody');
	NewtonCollisionAggregateRemoveBody:= linked_functions[232].function_ptr;
	linked_functions[233].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionAggregateGetSelfCollision');
	NewtonCollisionAggregateGetSelfCollision:= linked_functions[233].function_ptr;
	linked_functions[234].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCollisionAggregateSetSelfCollision');
	NewtonCollisionAggregateSetSelfCollision:= linked_functions[234].function_ptr;
	linked_functions[235].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSetEulerAngle');
	NewtonSetEulerAngle:= linked_functions[235].function_ptr;
	linked_functions[236].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonGetEulerAngle');
	NewtonGetEulerAngle:= linked_functions[236].function_ptr;
	linked_functions[237].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCalculateSpringDamperAcceleration');
	NewtonCalculateSpringDamperAcceleration:= linked_functions[237].function_ptr;
	linked_functions[238].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCreateDynamicBody');
	NewtonCreateDynamicBody:= linked_functions[238].function_ptr;
	linked_functions[239].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCreateKinematicBody');
	NewtonCreateKinematicBody:= linked_functions[239].function_ptr;
	linked_functions[240].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCreateAsymetricDynamicBody');
	NewtonCreateAsymetricDynamicBody:= linked_functions[240].function_ptr;
	linked_functions[241].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonDestroyBody');
	NewtonDestroyBody:= linked_functions[241].function_ptr;
	linked_functions[242].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetSimulationState');
	NewtonBodyGetSimulationState:= linked_functions[242].function_ptr;
	linked_functions[243].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetSimulationState');
	NewtonBodySetSimulationState:= linked_functions[243].function_ptr;
	linked_functions[244].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetType');
	NewtonBodyGetType:= linked_functions[244].function_ptr;
	linked_functions[245].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetCollidable');
	NewtonBodyGetCollidable:= linked_functions[245].function_ptr;
	linked_functions[246].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetCollidable');
	NewtonBodySetCollidable:= linked_functions[246].function_ptr;
	linked_functions[247].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyAddForce');
	NewtonBodyAddForce:= linked_functions[247].function_ptr;
	linked_functions[248].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyAddTorque');
	NewtonBodyAddTorque:= linked_functions[248].function_ptr;
	linked_functions[249].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetCentreOfMass');
	NewtonBodySetCentreOfMass:= linked_functions[249].function_ptr;
	linked_functions[250].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetMassMatrix');
	NewtonBodySetMassMatrix:= linked_functions[250].function_ptr;
	linked_functions[251].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetFullMassMatrix');
	NewtonBodySetFullMassMatrix:= linked_functions[251].function_ptr;
	linked_functions[252].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetMassProperties');
	NewtonBodySetMassProperties:= linked_functions[252].function_ptr;
	linked_functions[253].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetMatrix');
	NewtonBodySetMatrix:= linked_functions[253].function_ptr;
	linked_functions[254].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetMatrixNoSleep');
	NewtonBodySetMatrixNoSleep:= linked_functions[254].function_ptr;
	linked_functions[255].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetMatrixRecursive');
	NewtonBodySetMatrixRecursive:= linked_functions[255].function_ptr;
	linked_functions[256].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetMaterialGroupID');
	NewtonBodySetMaterialGroupID:= linked_functions[256].function_ptr;
	linked_functions[257].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetContinuousCollisionMode');
	NewtonBodySetContinuousCollisionMode:= linked_functions[257].function_ptr;
	linked_functions[258].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetJointRecursiveCollision');
	NewtonBodySetJointRecursiveCollision:= linked_functions[258].function_ptr;
	linked_functions[259].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetOmega');
	NewtonBodySetOmega:= linked_functions[259].function_ptr;
	linked_functions[260].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetOmegaNoSleep');
	NewtonBodySetOmegaNoSleep:= linked_functions[260].function_ptr;
	linked_functions[261].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetVelocity');
	NewtonBodySetVelocity:= linked_functions[261].function_ptr;
	linked_functions[262].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetVelocityNoSleep');
	NewtonBodySetVelocityNoSleep:= linked_functions[262].function_ptr;
	linked_functions[263].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetForce');
	NewtonBodySetForce:= linked_functions[263].function_ptr;
	linked_functions[264].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetTorque');
	NewtonBodySetTorque:= linked_functions[264].function_ptr;
	linked_functions[265].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetLinearDamping');
	NewtonBodySetLinearDamping:= linked_functions[265].function_ptr;
	linked_functions[266].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetAngularDamping');
	NewtonBodySetAngularDamping:= linked_functions[266].function_ptr;
	linked_functions[267].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetCollision');
	NewtonBodySetCollision:= linked_functions[267].function_ptr;
	linked_functions[268].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetCollisionScale');
	NewtonBodySetCollisionScale:= linked_functions[268].function_ptr;
	linked_functions[269].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetSleepState');
	NewtonBodyGetSleepState:= linked_functions[269].function_ptr;
	linked_functions[270].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetSleepState');
	NewtonBodySetSleepState:= linked_functions[270].function_ptr;
	linked_functions[271].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetAutoSleep');
	NewtonBodyGetAutoSleep:= linked_functions[271].function_ptr;
	linked_functions[272].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetAutoSleep');
	NewtonBodySetAutoSleep:= linked_functions[272].function_ptr;
	linked_functions[273].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetFreezeState');
	NewtonBodyGetFreezeState:= linked_functions[273].function_ptr;
	linked_functions[274].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetFreezeState');
	NewtonBodySetFreezeState:= linked_functions[274].function_ptr;
	linked_functions[275].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetGyroscopicTorque');
	NewtonBodyGetGyroscopicTorque:= linked_functions[275].function_ptr;
	linked_functions[276].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetGyroscopicTorque');
	NewtonBodySetGyroscopicTorque:= linked_functions[276].function_ptr;
	linked_functions[277].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetDestructorCallback');
	NewtonBodySetDestructorCallback:= linked_functions[277].function_ptr;
	linked_functions[278].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetDestructorCallback');
	NewtonBodyGetDestructorCallback:= linked_functions[278].function_ptr;
	linked_functions[279].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetTransformCallback');
	NewtonBodySetTransformCallback:= linked_functions[279].function_ptr;
	linked_functions[280].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetTransformCallback');
	NewtonBodyGetTransformCallback:= linked_functions[280].function_ptr;
	linked_functions[281].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetForceAndTorqueCallback');
	NewtonBodySetForceAndTorqueCallback:= linked_functions[281].function_ptr;
	linked_functions[282].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetForceAndTorqueCallback');
	NewtonBodyGetForceAndTorqueCallback:= linked_functions[282].function_ptr;
	linked_functions[283].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetID');
	NewtonBodyGetID:= linked_functions[283].function_ptr;
	linked_functions[284].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodySetUserData');
	NewtonBodySetUserData:= linked_functions[284].function_ptr;
	linked_functions[285].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetUserData');
	NewtonBodyGetUserData:= linked_functions[285].function_ptr;
	linked_functions[286].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetWorld');
	NewtonBodyGetWorld:= linked_functions[286].function_ptr;
	linked_functions[287].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetCollision');
	NewtonBodyGetCollision:= linked_functions[287].function_ptr;
	linked_functions[288].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetMaterialGroupID');
	NewtonBodyGetMaterialGroupID:= linked_functions[288].function_ptr;
	linked_functions[289].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetSerializedID');
	NewtonBodyGetSerializedID:= linked_functions[289].function_ptr;
	linked_functions[290].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetContinuousCollisionMode');
	NewtonBodyGetContinuousCollisionMode:= linked_functions[290].function_ptr;
	linked_functions[291].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetJointRecursiveCollision');
	NewtonBodyGetJointRecursiveCollision:= linked_functions[291].function_ptr;
	linked_functions[292].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetPosition');
	NewtonBodyGetPosition:= linked_functions[292].function_ptr;
	linked_functions[293].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetMatrix');
	NewtonBodyGetMatrix:= linked_functions[293].function_ptr;
	linked_functions[294].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetRotation');
	NewtonBodyGetRotation:= linked_functions[294].function_ptr;
	linked_functions[295].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetMass');
	NewtonBodyGetMass:= linked_functions[295].function_ptr;
	linked_functions[296].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetInvMass');
	NewtonBodyGetInvMass:= linked_functions[296].function_ptr;
	linked_functions[297].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetInertiaMatrix');
	NewtonBodyGetInertiaMatrix:= linked_functions[297].function_ptr;
	linked_functions[298].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetInvInertiaMatrix');
	NewtonBodyGetInvInertiaMatrix:= linked_functions[298].function_ptr;
	linked_functions[299].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetOmega');
	NewtonBodyGetOmega:= linked_functions[299].function_ptr;
	linked_functions[300].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetVelocity');
	NewtonBodyGetVelocity:= linked_functions[300].function_ptr;
	linked_functions[301].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetAlpha');
	NewtonBodyGetAlpha:= linked_functions[301].function_ptr;
	linked_functions[302].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetAcceleration');
	NewtonBodyGetAcceleration:= linked_functions[302].function_ptr;
	linked_functions[303].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetForce');
	NewtonBodyGetForce:= linked_functions[303].function_ptr;
	linked_functions[304].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetTorque');
	NewtonBodyGetTorque:= linked_functions[304].function_ptr;
	linked_functions[305].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetCentreOfMass');
	NewtonBodyGetCentreOfMass:= linked_functions[305].function_ptr;
	linked_functions[306].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetPointVelocity');
	NewtonBodyGetPointVelocity:= linked_functions[306].function_ptr;
	linked_functions[307].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyApplyImpulsePair');
	NewtonBodyApplyImpulsePair:= linked_functions[307].function_ptr;
	linked_functions[308].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyAddImpulse');
	NewtonBodyAddImpulse:= linked_functions[308].function_ptr;
	linked_functions[309].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyApplyImpulseArray');
	NewtonBodyApplyImpulseArray:= linked_functions[309].function_ptr;
	linked_functions[310].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyIntegrateVelocity');
	NewtonBodyIntegrateVelocity:= linked_functions[310].function_ptr;
	linked_functions[311].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetLinearDamping');
	NewtonBodyGetLinearDamping:= linked_functions[311].function_ptr;
	linked_functions[312].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetAngularDamping');
	NewtonBodyGetAngularDamping:= linked_functions[312].function_ptr;
	linked_functions[313].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetAABB');
	NewtonBodyGetAABB:= linked_functions[313].function_ptr;
	linked_functions[314].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetFirstJoint');
	NewtonBodyGetFirstJoint:= linked_functions[314].function_ptr;
	linked_functions[315].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetNextJoint');
	NewtonBodyGetNextJoint:= linked_functions[315].function_ptr;
	linked_functions[316].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetFirstContactJoint');
	NewtonBodyGetFirstContactJoint:= linked_functions[316].function_ptr;
	linked_functions[317].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyGetNextContactJoint');
	NewtonBodyGetNextContactJoint:= linked_functions[317].function_ptr;
	linked_functions[318].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBodyFindContact');
	NewtonBodyFindContact:= linked_functions[318].function_ptr;
	linked_functions[319].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonContactJointGetFirstContact');
	NewtonContactJointGetFirstContact:= linked_functions[319].function_ptr;
	linked_functions[320].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonContactJointGetNextContact');
	NewtonContactJointGetNextContact:= linked_functions[320].function_ptr;
	linked_functions[321].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonContactJointGetContactCount');
	NewtonContactJointGetContactCount:= linked_functions[321].function_ptr;
	linked_functions[322].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonContactJointRemoveContact');
	NewtonContactJointRemoveContact:= linked_functions[322].function_ptr;
	linked_functions[323].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonContactJointGetClosestDistance');
	NewtonContactJointGetClosestDistance:= linked_functions[323].function_ptr;
	linked_functions[324].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonContactJointResetSelftJointCollision');
	NewtonContactJointResetSelftJointCollision:= linked_functions[324].function_ptr;
	linked_functions[325].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonContactJointResetIntraJointCollision');
	NewtonContactJointResetIntraJointCollision:= linked_functions[325].function_ptr;
	linked_functions[326].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonContactGetMaterial');
	NewtonContactGetMaterial:= linked_functions[326].function_ptr;
	linked_functions[327].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonContactGetCollision0');
	NewtonContactGetCollision0:= linked_functions[327].function_ptr;
	linked_functions[328].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonContactGetCollision1');
	NewtonContactGetCollision1:= linked_functions[328].function_ptr;
	linked_functions[329].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonContactGetCollisionID0');
	NewtonContactGetCollisionID0:= linked_functions[329].function_ptr;
	linked_functions[330].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonContactGetCollisionID1');
	NewtonContactGetCollisionID1:= linked_functions[330].function_ptr;
	linked_functions[331].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonJointGetUserData');
	NewtonJointGetUserData:= linked_functions[331].function_ptr;
	linked_functions[332].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonJointSetUserData');
	NewtonJointSetUserData:= linked_functions[332].function_ptr;
	linked_functions[333].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonJointGetBody0');
	NewtonJointGetBody0:= linked_functions[333].function_ptr;
	linked_functions[334].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonJointGetBody1');
	NewtonJointGetBody1:= linked_functions[334].function_ptr;
	linked_functions[335].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonJointGetInfo');
	NewtonJointGetInfo:= linked_functions[335].function_ptr;
	linked_functions[336].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonJointGetCollisionState');
	NewtonJointGetCollisionState:= linked_functions[336].function_ptr;
	linked_functions[337].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonJointSetCollisionState');
	NewtonJointSetCollisionState:= linked_functions[337].function_ptr;
	linked_functions[338].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonJointGetStiffness');
	NewtonJointGetStiffness:= linked_functions[338].function_ptr;
	linked_functions[339].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonJointSetStiffness');
	NewtonJointSetStiffness:= linked_functions[339].function_ptr;
	linked_functions[340].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonDestroyJoint');
	NewtonDestroyJoint:= linked_functions[340].function_ptr;
	linked_functions[341].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonJointSetDestructor');
	NewtonJointSetDestructor:= linked_functions[341].function_ptr;
	linked_functions[342].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonJointIsActive');
	NewtonJointIsActive:= linked_functions[342].function_ptr;
	linked_functions[343].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCreateMassSpringDamperSystem');
	NewtonCreateMassSpringDamperSystem:= linked_functions[343].function_ptr;
	linked_functions[344].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCreateDeformableSolid');
	NewtonCreateDeformableSolid:= linked_functions[344].function_ptr;
	linked_functions[345].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonDeformableMeshGetParticleCount');
	NewtonDeformableMeshGetParticleCount:= linked_functions[345].function_ptr;
	linked_functions[346].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonDeformableMeshGetParticleStrideInBytes');
	NewtonDeformableMeshGetParticleStrideInBytes:= linked_functions[346].function_ptr;
	linked_functions[347].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonDeformableMeshGetParticleArray');
	NewtonDeformableMeshGetParticleArray:= linked_functions[347].function_ptr;
	linked_functions[348].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonConstraintCreateBall');
	NewtonConstraintCreateBall:= linked_functions[348].function_ptr;
	linked_functions[349].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBallSetUserCallback');
	NewtonBallSetUserCallback:= linked_functions[349].function_ptr;
	linked_functions[350].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBallGetJointAngle');
	NewtonBallGetJointAngle:= linked_functions[350].function_ptr;
	linked_functions[351].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBallGetJointOmega');
	NewtonBallGetJointOmega:= linked_functions[351].function_ptr;
	linked_functions[352].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBallGetJointForce');
	NewtonBallGetJointForce:= linked_functions[352].function_ptr;
	linked_functions[353].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonBallSetConeLimits');
	NewtonBallSetConeLimits:= linked_functions[353].function_ptr;
	linked_functions[354].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonConstraintCreateHinge');
	NewtonConstraintCreateHinge:= linked_functions[354].function_ptr;
	linked_functions[355].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonHingeSetUserCallback');
	NewtonHingeSetUserCallback:= linked_functions[355].function_ptr;
	linked_functions[356].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonHingeGetJointAngle');
	NewtonHingeGetJointAngle:= linked_functions[356].function_ptr;
	linked_functions[357].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonHingeGetJointOmega');
	NewtonHingeGetJointOmega:= linked_functions[357].function_ptr;
	linked_functions[358].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonHingeGetJointForce');
	NewtonHingeGetJointForce:= linked_functions[358].function_ptr;
	linked_functions[359].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonHingeCalculateStopAlpha');
	NewtonHingeCalculateStopAlpha:= linked_functions[359].function_ptr;
	linked_functions[360].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonConstraintCreateSlider');
	NewtonConstraintCreateSlider:= linked_functions[360].function_ptr;
	linked_functions[361].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSliderSetUserCallback');
	NewtonSliderSetUserCallback:= linked_functions[361].function_ptr;
	linked_functions[362].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSliderGetJointPosit');
	NewtonSliderGetJointPosit:= linked_functions[362].function_ptr;
	linked_functions[363].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSliderGetJointVeloc');
	NewtonSliderGetJointVeloc:= linked_functions[363].function_ptr;
	linked_functions[364].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSliderGetJointForce');
	NewtonSliderGetJointForce:= linked_functions[364].function_ptr;
	linked_functions[365].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonSliderCalculateStopAccel');
	NewtonSliderCalculateStopAccel:= linked_functions[365].function_ptr;
	linked_functions[366].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonConstraintCreateCorkscrew');
	NewtonConstraintCreateCorkscrew:= linked_functions[366].function_ptr;
	linked_functions[367].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCorkscrewSetUserCallback');
	NewtonCorkscrewSetUserCallback:= linked_functions[367].function_ptr;
	linked_functions[368].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCorkscrewGetJointPosit');
	NewtonCorkscrewGetJointPosit:= linked_functions[368].function_ptr;
	linked_functions[369].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCorkscrewGetJointAngle');
	NewtonCorkscrewGetJointAngle:= linked_functions[369].function_ptr;
	linked_functions[370].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCorkscrewGetJointVeloc');
	NewtonCorkscrewGetJointVeloc:= linked_functions[370].function_ptr;
	linked_functions[371].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCorkscrewGetJointOmega');
	NewtonCorkscrewGetJointOmega:= linked_functions[371].function_ptr;
	linked_functions[372].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCorkscrewGetJointForce');
	NewtonCorkscrewGetJointForce:= linked_functions[372].function_ptr;
	linked_functions[373].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCorkscrewCalculateStopAlpha');
	NewtonCorkscrewCalculateStopAlpha:= linked_functions[373].function_ptr;
	linked_functions[374].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCorkscrewCalculateStopAccel');
	NewtonCorkscrewCalculateStopAccel:= linked_functions[374].function_ptr;
	linked_functions[375].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonConstraintCreateUniversal');
	NewtonConstraintCreateUniversal:= linked_functions[375].function_ptr;
	linked_functions[376].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUniversalSetUserCallback');
	NewtonUniversalSetUserCallback:= linked_functions[376].function_ptr;
	linked_functions[377].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUniversalGetJointAngle0');
	NewtonUniversalGetJointAngle0:= linked_functions[377].function_ptr;
	linked_functions[378].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUniversalGetJointAngle1');
	NewtonUniversalGetJointAngle1:= linked_functions[378].function_ptr;
	linked_functions[379].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUniversalGetJointOmega0');
	NewtonUniversalGetJointOmega0:= linked_functions[379].function_ptr;
	linked_functions[380].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUniversalGetJointOmega1');
	NewtonUniversalGetJointOmega1:= linked_functions[380].function_ptr;
	linked_functions[381].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUniversalGetJointForce');
	NewtonUniversalGetJointForce:= linked_functions[381].function_ptr;
	linked_functions[382].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUniversalCalculateStopAlpha0');
	NewtonUniversalCalculateStopAlpha0:= linked_functions[382].function_ptr;
	linked_functions[383].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUniversalCalculateStopAlpha1');
	NewtonUniversalCalculateStopAlpha1:= linked_functions[383].function_ptr;
	linked_functions[384].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonConstraintCreateUpVector');
	NewtonConstraintCreateUpVector:= linked_functions[384].function_ptr;
	linked_functions[385].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUpVectorGetPin');
	NewtonUpVectorGetPin:= linked_functions[385].function_ptr;
	linked_functions[386].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUpVectorSetPin');
	NewtonUpVectorSetPin:= linked_functions[386].function_ptr;
	linked_functions[387].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonConstraintCreateUserJoint');
	NewtonConstraintCreateUserJoint:= linked_functions[387].function_ptr;
	linked_functions[388].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUserJointGetSolverModel');
	NewtonUserJointGetSolverModel:= linked_functions[388].function_ptr;
	linked_functions[389].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUserJointSetSolverModel');
	NewtonUserJointSetSolverModel:= linked_functions[389].function_ptr;
	linked_functions[390].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUserJointMassScale');
	NewtonUserJointMassScale:= linked_functions[390].function_ptr;
	linked_functions[391].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUserJointSetFeedbackCollectorCallback');
	NewtonUserJointSetFeedbackCollectorCallback:= linked_functions[391].function_ptr;
	linked_functions[392].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUserJointAddLinearRow');
	NewtonUserJointAddLinearRow:= linked_functions[392].function_ptr;
	linked_functions[393].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUserJointAddAngularRow');
	NewtonUserJointAddAngularRow:= linked_functions[393].function_ptr;
	linked_functions[394].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUserJointAddGeneralRow');
	NewtonUserJointAddGeneralRow:= linked_functions[394].function_ptr;
	linked_functions[395].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUserJointSetRowMinimumFriction');
	NewtonUserJointSetRowMinimumFriction:= linked_functions[395].function_ptr;
	linked_functions[396].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUserJointSetRowMaximumFriction');
	NewtonUserJointSetRowMaximumFriction:= linked_functions[396].function_ptr;
	linked_functions[397].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUserJointCalculateRowZeroAcceleration');
	NewtonUserJointCalculateRowZeroAcceleration:= linked_functions[397].function_ptr;
	linked_functions[398].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUserJointGetRowAcceleration');
	NewtonUserJointGetRowAcceleration:= linked_functions[398].function_ptr;
	linked_functions[399].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUserJointGetRowJacobian');
	NewtonUserJointGetRowJacobian:= linked_functions[399].function_ptr;
	linked_functions[400].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUserJointSetRowAcceleration');
	NewtonUserJointSetRowAcceleration:= linked_functions[400].function_ptr;
	linked_functions[401].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUserJointSetRowSpringDamperAcceleration');
	NewtonUserJointSetRowSpringDamperAcceleration:= linked_functions[401].function_ptr;
	linked_functions[402].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUserJointSetRowStiffness');
	NewtonUserJointSetRowStiffness:= linked_functions[402].function_ptr;
	linked_functions[403].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUserJoinRowsCount');
	NewtonUserJoinRowsCount:= linked_functions[403].function_ptr;
	linked_functions[404].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUserJointGetGeneralRow');
	NewtonUserJointGetGeneralRow:= linked_functions[404].function_ptr;
	linked_functions[405].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonUserJointGetRowForce');
	NewtonUserJointGetRowForce:= linked_functions[405].function_ptr;
	linked_functions[406].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshCreate');
	NewtonMeshCreate:= linked_functions[406].function_ptr;
	linked_functions[407].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshCreateFromMesh');
	NewtonMeshCreateFromMesh:= linked_functions[407].function_ptr;
	linked_functions[408].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshCreateFromCollision');
	NewtonMeshCreateFromCollision:= linked_functions[408].function_ptr;
	linked_functions[409].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshCreateTetrahedraIsoSurface');
	NewtonMeshCreateTetrahedraIsoSurface:= linked_functions[409].function_ptr;
	linked_functions[410].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshCreateConvexHull');
	NewtonMeshCreateConvexHull:= linked_functions[410].function_ptr;
	linked_functions[411].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshCreateVoronoiConvexDecomposition');
	NewtonMeshCreateVoronoiConvexDecomposition:= linked_functions[411].function_ptr;
	linked_functions[412].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshCreateFromSerialization');
	NewtonMeshCreateFromSerialization:= linked_functions[412].function_ptr;
	linked_functions[413].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshDestroy');
	NewtonMeshDestroy:= linked_functions[413].function_ptr;
	linked_functions[414].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshSerialize');
	NewtonMeshSerialize:= linked_functions[414].function_ptr;
	linked_functions[415].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshSaveOFF');
	NewtonMeshSaveOFF:= linked_functions[415].function_ptr;
	linked_functions[416].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshLoadOFF');
	NewtonMeshLoadOFF:= linked_functions[416].function_ptr;
	linked_functions[417].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshLoadTetrahedraMesh');
	NewtonMeshLoadTetrahedraMesh:= linked_functions[417].function_ptr;
	linked_functions[418].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshFlipWinding');
	NewtonMeshFlipWinding:= linked_functions[418].function_ptr;
	linked_functions[419].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshApplyTransform');
	NewtonMeshApplyTransform:= linked_functions[419].function_ptr;
	linked_functions[420].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshCalculateOOBB');
	NewtonMeshCalculateOOBB:= linked_functions[420].function_ptr;
	linked_functions[421].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshCalculateVertexNormals');
	NewtonMeshCalculateVertexNormals:= linked_functions[421].function_ptr;
	linked_functions[422].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshApplySphericalMapping');
	NewtonMeshApplySphericalMapping:= linked_functions[422].function_ptr;
	linked_functions[423].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshApplyCylindricalMapping');
	NewtonMeshApplyCylindricalMapping:= linked_functions[423].function_ptr;
	linked_functions[424].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshApplyBoxMapping');
	NewtonMeshApplyBoxMapping:= linked_functions[424].function_ptr;
	linked_functions[425].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshApplyAngleBasedMapping');
	NewtonMeshApplyAngleBasedMapping:= linked_functions[425].function_ptr;
	linked_functions[426].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonCreateTetrahedraLinearBlendSkinWeightsChannel');
	NewtonCreateTetrahedraLinearBlendSkinWeightsChannel:= linked_functions[426].function_ptr;
	linked_functions[427].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshOptimize');
	NewtonMeshOptimize:= linked_functions[427].function_ptr;
	linked_functions[428].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshOptimizePoints');
	NewtonMeshOptimizePoints:= linked_functions[428].function_ptr;
	linked_functions[429].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshOptimizeVertex');
	NewtonMeshOptimizeVertex:= linked_functions[429].function_ptr;
	linked_functions[430].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshIsOpenMesh');
	NewtonMeshIsOpenMesh:= linked_functions[430].function_ptr;
	linked_functions[431].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshFixTJoints');
	NewtonMeshFixTJoints:= linked_functions[431].function_ptr;
	linked_functions[432].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshPolygonize');
	NewtonMeshPolygonize:= linked_functions[432].function_ptr;
	linked_functions[433].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshTriangulate');
	NewtonMeshTriangulate:= linked_functions[433].function_ptr;
	linked_functions[434].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshUnion');
	NewtonMeshUnion:= linked_functions[434].function_ptr;
	linked_functions[435].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshDifference');
	NewtonMeshDifference:= linked_functions[435].function_ptr;
	linked_functions[436].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshIntersection');
	NewtonMeshIntersection:= linked_functions[436].function_ptr;
	linked_functions[437].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshClip');
	NewtonMeshClip:= linked_functions[437].function_ptr;
	linked_functions[438].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshConvexMeshIntersection');
	NewtonMeshConvexMeshIntersection:= linked_functions[438].function_ptr;
	linked_functions[439].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshSimplify');
	NewtonMeshSimplify:= linked_functions[439].function_ptr;
	linked_functions[440].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshApproximateConvexDecomposition');
	NewtonMeshApproximateConvexDecomposition:= linked_functions[440].function_ptr;
	linked_functions[441].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonRemoveUnusedVertices');
	NewtonRemoveUnusedVertices:= linked_functions[441].function_ptr;
	linked_functions[442].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshBeginBuild');
	NewtonMeshBeginBuild:= linked_functions[442].function_ptr;
	linked_functions[443].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshBeginFace');
	NewtonMeshBeginFace:= linked_functions[443].function_ptr;
	linked_functions[444].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshAddPoint');
	NewtonMeshAddPoint:= linked_functions[444].function_ptr;
	linked_functions[445].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshAddLayer');
	NewtonMeshAddLayer:= linked_functions[445].function_ptr;
	linked_functions[446].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshAddMaterial');
	NewtonMeshAddMaterial:= linked_functions[446].function_ptr;
	linked_functions[447].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshAddNormal');
	NewtonMeshAddNormal:= linked_functions[447].function_ptr;
	linked_functions[448].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshAddBinormal');
	NewtonMeshAddBinormal:= linked_functions[448].function_ptr;
	linked_functions[449].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshAddUV0');
	NewtonMeshAddUV0:= linked_functions[449].function_ptr;
	linked_functions[450].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshAddUV1');
	NewtonMeshAddUV1:= linked_functions[450].function_ptr;
	linked_functions[451].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshAddVertexColor');
	NewtonMeshAddVertexColor:= linked_functions[451].function_ptr;
	linked_functions[452].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshEndFace');
	NewtonMeshEndFace:= linked_functions[452].function_ptr;
	linked_functions[453].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshEndBuild');
	NewtonMeshEndBuild:= linked_functions[453].function_ptr;
	linked_functions[454].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshClearVertexFormat');
	NewtonMeshClearVertexFormat:= linked_functions[454].function_ptr;
	linked_functions[455].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshBuildFromVertexListIndexList');
	NewtonMeshBuildFromVertexListIndexList:= linked_functions[455].function_ptr;
	linked_functions[456].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetPointCount');
	NewtonMeshGetPointCount:= linked_functions[456].function_ptr;
	linked_functions[457].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetIndexToVertexMap');
	NewtonMeshGetIndexToVertexMap:= linked_functions[457].function_ptr;
	linked_functions[458].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetVertexDoubleChannel');
	NewtonMeshGetVertexDoubleChannel:= linked_functions[458].function_ptr;
	linked_functions[459].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetVertexChannel');
	NewtonMeshGetVertexChannel:= linked_functions[459].function_ptr;
	linked_functions[460].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetNormalChannel');
	NewtonMeshGetNormalChannel:= linked_functions[460].function_ptr;
	linked_functions[461].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetBinormalChannel');
	NewtonMeshGetBinormalChannel:= linked_functions[461].function_ptr;
	linked_functions[462].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetUV0Channel');
	NewtonMeshGetUV0Channel:= linked_functions[462].function_ptr;
	linked_functions[463].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetUV1Channel');
	NewtonMeshGetUV1Channel:= linked_functions[463].function_ptr;
	linked_functions[464].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetVertexColorChannel');
	NewtonMeshGetVertexColorChannel:= linked_functions[464].function_ptr;
	linked_functions[465].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshHasNormalChannel');
	NewtonMeshHasNormalChannel:= linked_functions[465].function_ptr;
	linked_functions[466].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshHasBinormalChannel');
	NewtonMeshHasBinormalChannel:= linked_functions[466].function_ptr;
	linked_functions[467].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshHasUV0Channel');
	NewtonMeshHasUV0Channel:= linked_functions[467].function_ptr;
	linked_functions[468].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshHasUV1Channel');
	NewtonMeshHasUV1Channel:= linked_functions[468].function_ptr;
	linked_functions[469].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshHasVertexColorChannel');
	NewtonMeshHasVertexColorChannel:= linked_functions[469].function_ptr;
	linked_functions[470].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshBeginHandle');
	NewtonMeshBeginHandle:= linked_functions[470].function_ptr;
	linked_functions[471].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshEndHandle');
	NewtonMeshEndHandle:= linked_functions[471].function_ptr;
	linked_functions[472].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshFirstMaterial');
	NewtonMeshFirstMaterial:= linked_functions[472].function_ptr;
	linked_functions[473].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshNextMaterial');
	NewtonMeshNextMaterial:= linked_functions[473].function_ptr;
	linked_functions[474].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshMaterialGetMaterial');
	NewtonMeshMaterialGetMaterial:= linked_functions[474].function_ptr;
	linked_functions[475].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshMaterialGetIndexCount');
	NewtonMeshMaterialGetIndexCount:= linked_functions[475].function_ptr;
	linked_functions[476].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshMaterialGetIndexStream');
	NewtonMeshMaterialGetIndexStream:= linked_functions[476].function_ptr;
	linked_functions[477].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshMaterialGetIndexStreamShort');
	NewtonMeshMaterialGetIndexStreamShort:= linked_functions[477].function_ptr;
	linked_functions[478].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshCreateFirstSingleSegment');
	NewtonMeshCreateFirstSingleSegment:= linked_functions[478].function_ptr;
	linked_functions[479].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshCreateNextSingleSegment');
	NewtonMeshCreateNextSingleSegment:= linked_functions[479].function_ptr;
	linked_functions[480].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshCreateFirstLayer');
	NewtonMeshCreateFirstLayer:= linked_functions[480].function_ptr;
	linked_functions[481].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshCreateNextLayer');
	NewtonMeshCreateNextLayer:= linked_functions[481].function_ptr;
	linked_functions[482].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetTotalFaceCount');
	NewtonMeshGetTotalFaceCount:= linked_functions[482].function_ptr;
	linked_functions[483].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetTotalIndexCount');
	NewtonMeshGetTotalIndexCount:= linked_functions[483].function_ptr;
	linked_functions[484].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetFaces');
	NewtonMeshGetFaces:= linked_functions[484].function_ptr;
	linked_functions[485].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetVertexCount');
	NewtonMeshGetVertexCount:= linked_functions[485].function_ptr;
	linked_functions[486].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetVertexStrideInByte');
	NewtonMeshGetVertexStrideInByte:= linked_functions[486].function_ptr;
	linked_functions[487].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetVertexArray');
	NewtonMeshGetVertexArray:= linked_functions[487].function_ptr;
	linked_functions[488].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetVertexBaseCount');
	NewtonMeshGetVertexBaseCount:= linked_functions[488].function_ptr;
	linked_functions[489].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshSetVertexBaseCount');
	NewtonMeshSetVertexBaseCount:= linked_functions[489].function_ptr;
	linked_functions[490].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetFirstVertex');
	NewtonMeshGetFirstVertex:= linked_functions[490].function_ptr;
	linked_functions[491].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetNextVertex');
	NewtonMeshGetNextVertex:= linked_functions[491].function_ptr;
	linked_functions[492].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetVertexIndex');
	NewtonMeshGetVertexIndex:= linked_functions[492].function_ptr;
	linked_functions[493].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetFirstPoint');
	NewtonMeshGetFirstPoint:= linked_functions[493].function_ptr;
	linked_functions[494].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetNextPoint');
	NewtonMeshGetNextPoint:= linked_functions[494].function_ptr;
	linked_functions[495].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetPointIndex');
	NewtonMeshGetPointIndex:= linked_functions[495].function_ptr;
	linked_functions[496].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetVertexIndexFromPoint');
	NewtonMeshGetVertexIndexFromPoint:= linked_functions[496].function_ptr;
	linked_functions[497].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetFirstEdge');
	NewtonMeshGetFirstEdge:= linked_functions[497].function_ptr;
	linked_functions[498].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetNextEdge');
	NewtonMeshGetNextEdge:= linked_functions[498].function_ptr;
	linked_functions[499].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetEdgeIndices');
	NewtonMeshGetEdgeIndices:= linked_functions[499].function_ptr;
	linked_functions[500].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetFirstFace');
	NewtonMeshGetFirstFace:= linked_functions[500].function_ptr;
	linked_functions[501].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetNextFace');
	NewtonMeshGetNextFace:= linked_functions[501].function_ptr;
	linked_functions[502].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshIsFaceOpen');
	NewtonMeshIsFaceOpen:= linked_functions[502].function_ptr;
	linked_functions[503].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetFaceMaterial');
	NewtonMeshGetFaceMaterial:= linked_functions[503].function_ptr;
	linked_functions[504].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetFaceIndexCount');
	NewtonMeshGetFaceIndexCount:= linked_functions[504].function_ptr;
	linked_functions[505].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetFaceIndices');
	NewtonMeshGetFaceIndices:= linked_functions[505].function_ptr;
	linked_functions[506].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshGetFacePointIndices');
	NewtonMeshGetFacePointIndices:= linked_functions[506].function_ptr;
	linked_functions[507].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshCalculateFaceNormal');
	NewtonMeshCalculateFaceNormal:= linked_functions[507].function_ptr;
	linked_functions[508].function_ptr := GetProcAddress(NewtonLibrary, 'NewtonMeshSetFaceMaterial');
	NewtonMeshSetFaceMaterial:= linked_functions[508].function_ptr;
end;

end.
