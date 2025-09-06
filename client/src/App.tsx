import React, { useState, useEffect } from 'react';
import { Task, apiService } from './services/api';
import AddTaskForm from './components/AddTaskForm';
import TaskList from './components/TaskList';

function App() {
  const [tasks, setTasks] = useState<Task[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const loadTasks = async () => {
    try {
      setError(null);
      const fetchedTasks = await apiService.getTasks();
      setTasks(fetchedTasks);
    } catch (err) {
      setError('Failed to load tasks. Please check if the server is running.');
      console.error('Error loading tasks:', err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadTasks();
  }, []);

  const handleAddTask = async (title: string, description: string) => {
    try {
      const newTask = await apiService.createTask({ title, description });
      setTasks(prev => [...prev, newTask]);
    } catch (err) {
      setError('Failed to add task. Please try again.');
      console.error('Error adding task:', err);
    }
  };

  const handleToggleComplete = async (id: string, completed: boolean) => {
    try {
      const updatedTask = await apiService.updateTask(id, { completed });
      setTasks(prev => prev.map(task => 
        task._id === id ? updatedTask : task
      ));
    } catch (err) {
      setError('Failed to update task. Please try again.');
      console.error('Error updating task:', err);
    }
  };

  const handleDeleteTask = async (id: string) => {
    try {
      await apiService.deleteTask(id);
      setTasks(prev => prev.filter(task => task._id !== id));
    } catch (err) {
      setError('Failed to delete task. Please try again.');
      console.error('Error deleting task:', err);
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-gray-100 flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-yellow-500 mx-auto mb-4"></div>
          <p className="text-gray-600">Loading tasks...</p>
        </div>
      </div>
    );
  }

// let ayush = 'unused variable to check actions'

  return (
    <div className="min-h-screen bg-gray-100 py-8">
      <div className="max-w-2xl mx-auto px-4">
        <header className="text-center mb-8">
          <h1 className="text-3xl font-bold text-gray-900 mb-2">Task Manager</h1>
          <p className="text-gray-600">Organize your tasks efficiently</p>
        </header>

        {error && (
          <div className="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded mb-6">
            <p className="font-medium">Error:</p>
            <p>{error}</p>
            <button
              onClick={() => setError(null)}
              className="mt-2 text-sm underline hover:no-underline"
            >
              Dismiss
            </button>
          </div>
        )}

        <AddTaskForm onAddTask={handleAddTask} />
        
        <div className="bg-white rounded-lg border-2 border-gray-300 p-6">
          <h2 className="text-xl font-semibold text-gray-900 mb-4">
            Your Tasks ({tasks.length})
          </h2>
          <TaskList
            tasks={tasks}
            onToggleComplete={handleToggleComplete}
            onDelete={handleDeleteTask}
          />
        </div>
      </div>
    </div>
  );
}

export default App;
