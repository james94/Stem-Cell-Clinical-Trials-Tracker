// SJSU CMPE 138 Fall 2021 TEAM1
import React from "react";
import axios from "axios";
import { withRouter } from "react-router-dom";
import { PATIIENT_API_BASE_URL } from "../settings/";

class SearchViewAllPatients extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      query: "",
      data: [],
      researcher_id: localStorage.getItem("id"),
      role: localStorage.getItem("role"),
      filteredData: [],
    };
    this.handleInputChange = this.handleInputChange.bind(this);
  }

  handleInputChange = (event) => {
    const query = event.target.value;

    this.setState((prevState) => {
      const filteredData = prevState.data.filter((element) => {
        return element.p_username
          .toLowerCase()
          .includes(query.toString().toLowerCase());
      });
      return {
        query,
        filteredData,
      };
    });
  };

  getData = () => {
    let config = {
      headers: {
        researcher_id: this.state.researcher_id,
        search: true,
      },
    };
    axios
      .get(PATIIENT_API_BASE_URL, config)
      .then((response) => {
        const query = this.state;
        const filteredData = response.data.filter((element) => {
          return element.p_username
            .toLowerCase()
            .includes(query.toString().toLowerCase());
        });

        this.setState({
          data: response.data,
          filteredData,
        });
      })
      .catch((error) => {
        console.log(error);
      });
  };

  componentDidMount() {
    this.getData();
  }

  render() {
    let searchCode;
    if (this.state.query.length === 0) searchCode = <div></div>;
    else {
      searchCode = (
        <div className="card" style={{ width: "100%" }}>
          <ul className="list-group list-group-flush">
            {this.state.filteredData.map((i, key) => (
              <li key={key} className="list-group-item">
                {i.p_username}
                <br /> Trial id: {i.trial_id}
                <br />
                Disease: {i.disease}
                <br /> Phase: {i.phase}
                <br /> Status: {i.p_status}
                <br /> Researcher id: {i.p_status}
              </li>
            ))}
          </ul>
        </div>
      );
    }
    return (
      <div className="container">
        <div className="row">
          <div className="col-sm-6 mx-auto">
            <h1
              className="my-4"
              style={{
                display: "flex",
                justifyContent: "center",
              }}
            >
              Search for all patients
            </h1>
            <form>
              <input
                style={{ width: "100%", height: "42px" }}
                placeholder="Enter patient username..."
                value={this.state.query}
                onChange={this.handleInputChange}
              />
              {searchCode}
            </form>
          </div>
        </div>
      </div>
    );
  }
}

export default withRouter(SearchViewAllPatients);
