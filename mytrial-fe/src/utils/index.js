// SJSU CMPE 138 Fall 2021 TEAM1
import axios from "axios";
import { createBrowserHistory } from "history";

axios.interceptors.request.use(
  (request) => {
    console.log("making request...");
    const role = localStorage.getItem("role");
    console.log(role);
    if (role === null) {
      console.log("role not selected");
      let history = createBrowserHistory();
      history.push("/");
      window.location.reload(false);
    }
    request.headers.Role = role;
    return request;
  },
  (error) => {
    console.log("error");
    return Promise.reject(error);
  }
);

export const fetchMytrial = async (url, params, request, data, headers) => {
  const fetchRequest = {
    ...request,
    url,
    params,
    data,
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
      ...headers,
    },
  };
  return axios(fetchRequest)
    .then((res) => {
      return res.data;
    })
    .catch((err) => {
      throw err;
    });
};

export const fetchMyPWatchlist = async (
  url,
  params,
  request,
  data,
  headers
) => {
  const fetchRequest = {
    ...request,
    url,
    params,
    data,
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
      ...headers,
    },
  };
  return axios(fetchRequest)
    .then((res) => {
      return res.data;
    })
    .catch((err) => {
      throw new Error(err.response.data);
    });
};
