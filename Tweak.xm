/* How to Hook with Logos
Hooks are written with syntax similar to that of an Objective-C @implementation.
You don't need to #include <substrate.h>, it will be done automatically, as will
the generation of a class list and an automatic constructor.

%hook ClassName

// Hooking a class method
+ (id)sharedInstance {
	return %orig;
}

// Hooking an instance method with an argument.
- (void)messageName:(int)argument {
	%log; // Write a message about this call, including its class, name and arguments, to the system log.

	%orig; // Call through to the original function with its original arguments.
	%orig(nil); // Call through to the original function with a custom argument.

	// If you use %orig(), you MUST supply all arguments (except for self and _cmd, the automatically generated ones.)
}

// Hooking an instance method with no arguments.
- (id)noArguments {
	%log;
	id awesome = %orig;
	[awesome doSomethingElse];

	return awesome;
}

// Always make sure you clean up after yourself; Not doing so could have grave consequences!
%end
*/


#define IS_IOS_OR_NEWER(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
%group iOS_6
%hook MNRouteSet

    - (BOOL)isNavigable {
        return YES;
    }

%end
%end

%group iOS_9
%hook GEORouteSetPage

    - (BOOL)isNavigable {
        return YES;
    }

%end
%end

%group iOS_10
%hook DirectionsManager
    - (BOOL)canRunNavigationForSelectedRoute {
        return YES;
    }
    - (BOOL)canRunNavigationForRoute: (id)route {
        return YES;
    }
%end
%end

%ctor{
    if(IS_IOS_OR_NEWER(@"10.0")){
        %init(iOS_10);
    }
    else{
        if(IS_IOS_OR_NEWER(@"9.0")){
            %init(iOS_9);
        }
        else{
            %init(iOS_6)
        }
    }
}
