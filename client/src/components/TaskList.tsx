import React from 'react';
import { Task } from '../services/api';

interface TaskListProps {
  tasks: Task[];
  onToggleComplete: (id: string, completed: boolean) => void;
  onDelete: (id: string) => void;
}

const TaskList: React.FC<TaskListProps> = ({ tasks, onToggleComplete, onDelete }) => {
  if (tasks.length === 0) {
    return (
      <div className="text-center py-8">
        <p className="text-gray-500">No tasks yet. Add one above to get started!</p>
      </div>
    );
  }

  return (
    <div className="space-y-3">
      {tasks.map((task) => (
        <div
          key={task._id}
          className={`p-4 rounded-lg border-2 transition-all duration-200 ${
            task.completed
              ? 'bg-gray-50 border-gray-200 opacity-75'
              : 'bg-white border-gray-300 hover:border-gray-400'
          }`}
        >
          <div className="flex items-start justify-between">
            <div className="flex-1">
              <div className="flex items-center space-x-3">
                <input
                  type="checkbox"
                  checked={task.completed}
                  onChange={(e) => onToggleComplete(task._id, e.target.checked)}
                  className="w-5 h-5 text-yellow-500 border-2 border-gray-300 rounded focus:ring-yellow-500 focus:ring-2"
                />
                <h3
                  className={`text-lg font-medium ${
                    task.completed ? 'line-through text-gray-500' : 'text-gray-900'
                  }`}
                >
                  {task.title}
                </h3>
              </div>
              {task.description && (
                <p
                  className={`mt-2 ml-8 ${
                    task.completed ? 'text-gray-400' : 'text-gray-600'
                  }`}
                >
                  {task.description}
                </p>
              )}
              <p className="mt-2 ml-8 text-xs text-gray-400">
                Created: {new Date(task.createdAt).toLocaleDateString()}
              </p>
            </div>
            <button
              onClick={() => onDelete(task._id)}
              className="ml-4 px-3 py-1 text-sm text-red-600 hover:text-red-800 hover:bg-red-50 rounded transition-colors"
            >
              Delete
            </button>
          </div>
        </div>
      ))}
    </div>
  );
};

export default TaskList;
