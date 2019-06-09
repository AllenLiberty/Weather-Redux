# Weather-Redux

I use redux architecture in this demo

Advantage: 
  1. The dataflow is unidirectional that means your data gets processed in one-direction. The idea behind it is that your subscribers (e. g. ViewController) only listens for updates and doesn’t manipulate the data it receives.
  2. You can find the real state of your app and model action. It make everything easy to understand
  3. Maximises separation of concerns. Every component does only one job.
  4. Improves testability. Reducers has pure functions that are really easy to test.
  
we can find the Action/Thunk/Store/State in this demo

  WeatherStore: receives actions uses the Reducer to replace the state, and fires off the new state to subscribed views
  WeatherState: a constant struct that defines and contains the state in memory. if In large app we can made up of sub-state
  WeatherReducer: a pure function that is given old state and an action, and it returns a new state struct that’ll replace the old one in the store.
  WeatherAction: simple structs that the Reducer uses to update state.
  WeatherThunk: implementation of the unidirectional data flow architecture in this case I do the netwok and requset location
  
  
