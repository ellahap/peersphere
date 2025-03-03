import { useState } from "react";

export default function PearSphere() {
  const [formData, setFormData] = useState({
    username: "",
    password: "",
    remember: true,
  });

  const handleChange = (e) => {
    const { name, value, type, checked } = e.target;
    setFormData((prev) => ({
      ...prev,
      [name]: type === "checkbox" ? checked : value,
    }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log("Form submitted", formData);
  };

  return (
    <div className="flex flex-col items-center p-4">
      <h1 className="text-2xl font-bold">PearSphere</h1>
      <p>hi</p>
      <form onSubmit={handleSubmit} className="w-80 p-4 border rounded-md shadow-md">
        <div className="mb-4">
          <label className="block font-bold">Username</label>
          <input
            type="text"
            name="username"
            placeholder="Enter Username"
            value={formData.username}
            onChange={handleChange}
            required
            className="w-full p-2 border rounded-md"
          />
        </div>
        <div className="mb-4">
          <label className="block font-bold">Password</label>
          <input
            type="password"
            name="password"
            placeholder="Enter Password"
            value={formData.password}
            onChange={handleChange}
            required
            className="w-full p-2 border rounded-md"
          />
        </div>
        <div className="mb-4 flex items-center">
          <input
            type="checkbox"
            name="remember"
            checked={formData.remember}
            onChange={handleChange}
            className="mr-2"
          />
          <label>Remember me</label>
        </div>
        <button type="submit" className="w-full p-2 bg-blue-500 text-white rounded-md">
          Login
        </button>
        <div className="mt-4 flex justify-between text-sm">
          <button type="button" className="text-red-500">Cancel</button>
          <span className="text-blue-500">
            Forgot <a href="#">password?</a>
          </span>
        </div>
      </form>
    </div>
  );
}
