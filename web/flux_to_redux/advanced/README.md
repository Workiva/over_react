# Advanced Flux to Redux Example
> An example showing the fundamentals of transitioning an architecture that includes multiple stores.

## Goal
As with the Simple example, the goal of this example is to illustrate how to go from a Flux only architecture to an __Influx__ architecture, and then finally to a Redux architecture. An __Influx__ archicture is one in which an application is running both Flux and Redux simaltenously, having both Redux and Flux components.

An Influx architecture is only necessary when the state archiecture is so complex that it is not realistic to transition all componentry from Flux to Redux in a short amount of time. By utilizing it, a library can have standard Flux components, Connected Flux components, and Connected Redux components simaltenously. Consequently, new components can be written using Redux patterns and Flux components can be slowly converted.

If the library's state architecture is simplistic enough, the examples can illustrate what a Flux store will look like after being converted to Redux.

## Beginning Flux Architecture
- Stores: The store architecture is comprised of two top level store classes (`TopLevelStore` and `SecondStore`). Within `TopLevelStore` there are two nested stores: `MidLevelStore` and `LowLevelStore`, with `LowLevelStore` being nested within `MidLevelStore`. Naturally in the real world each store architecture would be different, but for the sake of simplicity (and keeping the focus on the big picture), each store is essentially the same.

- Components: The only component rendered in the beginning is a Flux component. Each block in the UI has a background color derived from a different store, and there are a set of buttons to change each block background color.
<img height=400 src="./StartingArchitecture.png" alt='Starting Architecture'>

## Influx Architecture (during transition)
- Stores: In transition, the goal is to remove nesting from stores. Rather than having three stores nested one within another, they can be combined (flattened) or broken out into their own store. Additionally, they need to be wrapped by a class that can handle both Redux and Flux. General suggested steps to this step are:
    1. Make a plan for which components will be updated from Flux to Redux initially. Step 2 can be done without this knowledge as many complex store architectures will likely require almost all stores to be at least light refactored, but it may be possible to save some stores till a later point if only certain components need to be updated. This knowledge will also become more important in steps 3 and beyond. 
    1. Refactor stores to be shallow (a store cannot have a nested store within it). This can be done by either creating new stores or pulling the state up to the top level. This will also require a light component refactor to accept more stores access the correct stores.
    1. Wrap every Flux store in a `FluxToReduxAdapterStore`. 
    1. Create a context object for every store instance.

    Those are the steps necessary to get your library ready for `ConnectFlux`, and the remaining steps in this section build on these to add Redux as well. However, they can be done at a different time and you can begin refactoring components away from pure Flux at this point. To continue to implementing Redux, the remaining steps are:

    5. Make state fields, those required by Redux, mutatable to functions outside the store. In other words, remove the getter to allow the actual state variable to be setable. This goes against the Flux best practice, but is important for the Influx implementation to allow Redux to update the Flux store.
    1. Create a Redux action for every Flux action that needs to be mirrored by Redux. These actions can be empty classes, or all be the same class and have different `type` properties, or whatever seems most elegant when being used with a `reducer`. 
    1. Create a `reducer` for every store that will be accessed by Redux and uses the actions created in the previous step. This reducer should always return the `oldState`. Rather than returning a new state like Redux instructs, the `reducer` is going to mutate the corresponding Flux store and trigger an update. Pass that reducer into the `FluxToReduxAdapterStore` constructor used in step 3.
    
    These steps conclude the general refactor on the state / store side of the library.

- Components: After updating the store as described above, if you stopped at step 4 you can update to components to `ConnectFlux` components. If you completed all 7 steps, you will want to update to Redux components.

    1. Wrap your component tree in a `ReduxProvider` or `ReduxMultiProvider`. If you only have a single store to pass down to the components, a `ReduxProvider` will do. If you have multiple stores, use a `ReduxMultiProvider` to makes things more concise.
    1. Refactor your (soon to be) connected components to regular `UiComponent2`, switching out `props.store.example` for just `props.example`.
    1. Create a `Connected[ComponentNameGoesHere]` that wraps the component factory in a `ConnectFlux` or `Connect` call. Note that if this component still receives multiple stores, it will be helpful to wrap the factory in a `ComposeHocs` call. 
        - In the case there are multiple stores, you'll also need to utilize the context instances created in the store file and used with `ReduxMultiProvider`. 
        - This is also where you would connect `MapStateToProps` and `MapActionsToProps` / `MapDispatchToProps`.

- Example Specific Explanations
    - All of the variables had `InTranstion` appended as the root to names to differentiate them from the beginning phase variables.
    - The store architecture was updated to get rid of `MidLevelStore` and combine its fields with `TopLevelStore`. Then `LowLevelStore` was broken out as its own top level store. This could have been compined with `TopLevelStore` as well, but just wanted to show different approaches.
    - Added reducers, adapters, and context.
    - Wrapped components being rendered in a `ReduxMultiProvider`, adding the respective contexts and stores (adapted stores).
    - Refactored `RandomColorComponent` to be both a Flux and Redux connected component.
<img height=400 src="./InfluxArchitecture.png" alt='Influx Architecture'>
