componentName="lhmiscutil"

load( "ext://git_resource", "git_checkout" )
load( "./tilt/common/Tiltfile", "lhQuickBuildImage", "lhQuickBuildImageNoK8", "trySetTopLevelComponent" )
cfg = config.parse()
trySetTopLevelComponent(componentName)

lhQuickBuildImageNoK8( "lhscriptutil", cfg )
