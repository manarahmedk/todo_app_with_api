abstract class ToDoStates {}

class ToDoInitialState extends ToDoStates {}

class AddNewTaskLoadingState extends ToDoStates{}

class AddNewTaskSuccessState extends ToDoStates{}

class AddNewTaskErrorState extends ToDoStates{}

class UpdateTaskLoadingState extends ToDoStates{}

class UpdateTaskSuccessState extends ToDoStates{}

class UpdateTaskErrorState extends ToDoStates{}

class DeleteTaskLoadingState extends ToDoStates{}

class DeleteTaskSuccessState extends ToDoStates{}

class DeleteTaskErrorState extends ToDoStates{}

class GetAllTasksLoadingState extends ToDoStates{}

class GetAllTasksSuccessState extends ToDoStates{}

class GetAllTasksErrorState extends ToDoStates{}

class GetStatisticsLoadingState extends ToDoStates{}

class GetStatisticsSuccessState extends ToDoStates{}

class GetStatisticsErrorState extends ToDoStates{}

class UploadImageLoadingState extends ToDoStates{}

class UploadImageSuccessState extends ToDoStates{}

class UploadImageErrorState extends ToDoStates{}

class ClearAllDataState extends ToDoStates{}
